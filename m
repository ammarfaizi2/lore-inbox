Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTJONVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTJONVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:21:13 -0400
Received: from gprs150-9.eurotel.cz ([160.218.150.9]:61057 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263157AbTJONVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:21:10 -0400
Date: Wed, 15 Oct 2003 15:20:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015132054.GA840@elf.ucw.cz>
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031015121208.GA692@elf.ucw.cz> <20031015125109.GQ16158@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015125109.GQ16158@holomorphy.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not think this wants to be fixed. It should remain compatible
> > with 2.4.X, and if it is not that's a bug [and pretty dangerous & hard
> > to debug one -- if you mark something as ram which is not, you get
> > real bad data corruption].
> 
> 2.4:
> static void __init limit_regions (unsigned long long size)
> {
> 	unsigned long long current_addr = 0;
> 	int i;
> 
> 	for (i = 0; i < e820.nr_map; i++) {
> 		if (e820.map[i].type == E820_RAM) {
> 			current_addr = e820.map[i].addr + e820.map[i].size;
> 			if (current_addr >= size) {
> 				e820.map[i].size -= current_addr-size;
> 				e820.nr_map = i + 1;
> 				return;
> 			}
> 		}
> 	}
> }
> 
> 2.5:
> static void __init limit_regions (unsigned long long size)
> {
> 	int i;
> 	unsigned long long current_size = 0;
> 
> 	for (i = 0; i < e820.nr_map; i++) {
> 		if (e820.map[i].type == E820_RAM) {
> 			current_size += e820.map[i].size;
> 			if (current_size >= size) {
> 				e820.map[i].size -= current_size-size;
> 				e820.nr_map = i + 1;
> 				return;
> 			}
> 		}
> 	}
> }

Do you want to say that calculation is different, already? We should
probably make 2.5 version match 2.4 version, that's what users
expect. Who changed it and why?

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
