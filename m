Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTJOMsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTJOMsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:48:12 -0400
Received: from holomorphy.com ([66.224.33.161]:9109 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263076AbTJOMsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:48:08 -0400
Date: Wed, 15 Oct 2003 05:51:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015125109.GQ16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031015121208.GA692@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015121208.GA692@elf.ucw.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 02:12:08PM +0200, Pavel Machek wrote:
> I do not think this wants to be fixed. It should remain compatible
> with 2.4.X, and if it is not that's a bug [and pretty dangerous & hard
> to debug one -- if you mark something as ram which is not, you get
> real bad data corruption].

2.4:
static void __init limit_regions (unsigned long long size)
{
	unsigned long long current_addr = 0;
	int i;

	for (i = 0; i < e820.nr_map; i++) {
		if (e820.map[i].type == E820_RAM) {
			current_addr = e820.map[i].addr + e820.map[i].size;
			if (current_addr >= size) {
				e820.map[i].size -= current_addr-size;
				e820.nr_map = i + 1;
				return;
			}
		}
	}
}

2.5:
static void __init limit_regions (unsigned long long size)
{
	int i;
	unsigned long long current_size = 0;

	for (i = 0; i < e820.nr_map; i++) {
		if (e820.map[i].type == E820_RAM) {
			current_size += e820.map[i].size;
			if (current_size >= size) {
				e820.map[i].size -= current_size-size;
				e820.nr_map = i + 1;
				return;
			}
		}
	}
}
