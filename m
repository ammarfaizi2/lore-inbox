Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWAFL4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWAFL4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWAFL4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:56:22 -0500
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:23432 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750908AbWAFL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:56:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yuj7PIxHWCmm8R6n3Mcl7EUyTAbIQB3U/ze+uHSoiCQMUNP3b9cXdpBDNmFEBeY6d9kIgfIFzEb3rc1spT+Au9Xb3Vkl4V/BEYNYg3/3YRTpTuE0gDx1c3IAwqUqp2auHN6Umk21hGVm7VXBNSehpLxozrIjJTz/4EBnaNLunPk=  ;
Message-ID: <20060106115619.37841.qmail@web26913.mail.ukl.yahoo.com>
Date: Fri, 6 Jan 2006 12:56:19 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH 1/3] boot with Gujin: add script/{gzcopy.c,gzparam.c} to generate linux.kgz file format
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105160244.5e9df486.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Etienne Lorrain <etienne_lorrain@yahoo.fr> wrote:
> >
> > So this patch create a file script/gzcopy.c and Makefile
> > rules to produce script/gzcopy which can be use to view,
> > change (set/append/prepend) comment to GZIP files.
> > ...
> > This patch also contains the simple script/gzparam.c file
> > and its Makefile rules - that is a simple standalone
> > program to display a text line on stdout containing the
> > base pattern to generate the GZIP comment itself for
> > this configured kernel.
> 
> Those sound like things which should be distributed in
> the gzip package, not in the kernel source tree?

 The file script/gzparam.c is only related to GZIP by the
fact that the text line printed on stdout will be inserted
into the linux.kgz file as a GZIP comment, it has nothing to
do with the GZIP format itself.
 If you make and execute this gzparam manually, you will
see a line (depending on .config) printed on stdout like:
min_gujin_version=0x102 maskcpu=0x800000F0 maskDflags=0x021 \
   loadadr=0x100000 maskvesa=0x...
 gzparam means: kernel parameters to be inserted in the
comment line of the GZIP kernel file - to get a linux.kgz

 The file script/gzcopy.c would be better distributed in a
GZIP package if there was one such package and everybody
upgrades this package before trying to compile the kernel.
 But that file can also be considered as a better way than
using a script with sed/awk/cut/cat - its basic use is a
single string manipulation (initialise and concatenate
text strings - and insert it in a file at a defined offset).
 This utility is not made to evolve at all, and is so simple
it does not worth bothering - a bit like:
Linux/arch/i386/boot/tools/build.c .
 Note that I also send a message to jloup at the GZIP
homepage, but I am not sure I want to add another dependency
on GZIP package to build the kernel.

 Etienne.



	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
