Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWGYV32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWGYV32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWGYV32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:29:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54760 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964866AbWGYV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:29:27 -0400
From: Bodo Eggert <7eggert@elstempel.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 25 Jul 2006 23:28:29 +0200
References: <6CcT1-1lH-39@gated-at.bofh.it> <6Cwov-5xl-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G5USP-0000fF-Sp@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Subject: Re: what is necessary for directory hard links
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Joshua Hudson <joshudson@gmail.com> wrote:

> [...]
> 
>> Maybe someday I'll work out a system by which much less is locked.
>> Conceptually, all that is requred to lock for the algorithm
>> to work is creating hard-links to directories and renaming directories
>> cross-directory.
> 
> Some 40 years of filesystem development without finding a solution to that
> conundrum would make that quite unlikely, but you are certainly welcome to
> try.

There is a simple solution against loops: No directory may contain a directory
with a lower inode number.

Off cause this would interfere with normal operations, so you'll allocate all
normal inodes above e.g. 0x800000 and don't test between those inodes.

If you want to hardlink, you'll use a different (privileged) mkdir call
that will allocate a choosen low inode number. This is also required for
the parents of the hardlinked directories.

You can also use the generic solution: Allow root to shoot his feet, and
make sure the gun works correctly.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
