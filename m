Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUGDR1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUGDR1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUGDR1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:27:15 -0400
Received: from holomorphy.com ([207.189.100.168]:45258 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265215AbUGDR1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:27:12 -0400
Date: Sun, 4 Jul 2004 10:27:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
Subject: Re: move O_LARGEFILE forcing to filp_open()
Message-ID: <20040704172708.GI21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <200407041422.57614.arnd@arndb.de> <20040704161530.GF21066@holomorphy.com> <200407041922.45976.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407041922.45976.arnd@arndb.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 4. Juli 2004 18:15, William Lee Irwin III wrote:
>> Your patch is also necessary; thanks for covering these cases.

On Sun, Jul 04, 2004 at 07:22:42PM +0200, Arnd Bergmann wrote:
> I'm not sure if you understood the intention of compat_sys_open
> right. Old 32 bit applications assume they are not using O_LARGEFILE,
> so you can't switch it on unconditionally in filp_open() for those
> cases. With your patch applied, sys_open and compat_sys_open would
> be identical again, which reverses the point of my patch.
> What is need is a way to turn on O_LARGEFILE on 64 bit archs for
> every use of filp_open _except_ from compat_sys_open.

Oh, that's easy, just shove the MAX_NON_LFS check into compat_sys_open().


-- wli
