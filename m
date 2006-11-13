Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932960AbWKMTfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbWKMTfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933039AbWKMTfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:35:24 -0500
Received: from holoclan.de ([62.75.158.126]:18854 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S932960AbWKMTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:35:23 -0500
Date: Mon, 13 Nov 2006 20:34:43 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: paging request BUG in 2.6.19-rc5 on resume - X60s
Message-ID: <20061113193443.GF7942@gimli>
Mail-Followup-To: linux-thinkpad@linux-thinkpad.org,
	linux-kernel@vger.kernel.org
References: <20061113081147.GB5289@gimli> <1163426119.5871.26.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163426119.5871.26.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Nov 13, 2006 at 02:55:18PM +0100, Mike Galbraith
	wrote: > > Per ksymoops, that code is: > 0: ba 03 00 00 00 mov $0x3,%edx
	> 5: e9 ee fc fb ff jmp fffbfcf8 <_EIP+0xfffbfcf8> > a: 83 a0 2c 01 00
	00 b7 andl $0xffffffb7,0x12c(%eax) > 11: e9 00 00 00 00 jmp 16
	<_EIP+0x16> > > There is no such andl with an offset of 0x12c and that
	mask (I_LOCK| > I_NEW?) anywhere in my kernel or modules. How about
	yours? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 02:55:18PM +0100, Mike Galbraith wrote:
> 
> Per ksymoops, that code is:
>    0:   ba 03 00 00 00            mov    $0x3,%edx
>    5:   e9 ee fc fb ff            jmp    fffbfcf8 <_EIP+0xfffbfcf8>
>    a:   83 a0 2c 01 00 00 b7      andl   $0xffffffb7,0x12c(%eax)
>   11:   e9 00 00 00 00            jmp    16 <_EIP+0x16>
> 
> There is no such andl with an offset of 0x12c and that mask (I_LOCK|
> I_NEW?) anywhere in my kernel or modules.  How about yours?

$ objdump -D vmlinux | grep -5 'andl   $0xffffffb7,0x12c'
c016ff87:       05 2c 01 00 00          add    $0x12c,%eax
c016ff8c:       ba 03 00 00 00          mov    $0x3,%edx
c016ff91:       e9 ee fc fb ff          jmp    c012fc84 <wake_up_bit>

c016ff96 <unlock_new_inode>:
c016ff96:       83 a0 2c 01 00 00 b7    andl   $0xffffffb7,0x12c(%eax)
c016ff9d:       e9 e0 ff ff ff          jmp    c016ff82 <wake_up_inode>

c016ffa2 <inode_wait>:
c016ffa2:       e8 d1 3e 17 00          call   c02e3e78 <schedule>
c016ffa7:       31 c0                   xor    %eax,%eax

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
