Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVCOKsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVCOKsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVCOKsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:48:46 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:60095 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262375AbVCOKso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:48:44 -0500
Message-ID: <4236BD87.6000408@cosmosbay.com>
Date: Tue, 15 Mar 2005 11:48:39 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
Subject: x86: spin_unlock(), spin_unlock_irq() & others are out of line ?
References: <42348474.7040808@aknet.ru>	<20050313201020.GB8231@elf.ucw.cz>	<4234A8DD.9080305@aknet.ru>	<Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>	<4234B96C.9080901@aknet.ru>	<20050314192943.GG18826@devserv.devel.redhat.com>	<4235ED35.1000405@aknet.ru> <20050314193447.47ca6754.akpm@osdl.org>
In-Reply-To: <20050314193447.47ca6754.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 15 Mar 2005 11:48:34 +0100 (CET)
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I noticed that in current linux kernel versions (2.6.11), some basic 
functions are out of line (not inlined)

Example of a call to spin_unlock(&somelock)
c01069fa:   b8 e8 7b 35 c0          mov    $0xc0357be8,%eax
c01069ff:   e8 3c e4 1f 00          call   c0304e40 <_spin_unlock>


c0304e40 <_spin_unlock>:
c0304e40:   c6 00 01                movb   $0x1,(%eax)
c0304e43:   c3                      ret


Same problem for _write_unlock(), _read_unlock(), _spin_unlock_irq(), ...

That seems odd, and I fail to see the reason for that. (It's OK for 
complex functions, but not for very short ones...)

Is it a regression, or is it needed ?

configuration :
	- SMP
	- Processor family (Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon)
	- No "Generic x86 support"

Thank you
Eric Dumazet

