Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUGUHEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUGUHEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 03:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUGUHEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 03:04:31 -0400
Received: from gandalf.impreva.com ([212.29.208.227]:65230 "EHLO
	gandalf.webcohort.com") by vger.kernel.org with ESMTP
	id S266290AbUGUHE3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 03:04:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: module name is KBUILD_MODNAME
Date: Wed, 21 Jul 2004 10:05:33 +0200
Message-ID: <96242ACDF1723A4BBF70D21211FB9B23063690@shrek.webcohort.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: module name is KBUILD_MODNAME
Thread-Index: AcRuheJXFtJUUtm8RcqpwqznBoP+IgAcpR0w
From: "Idan Spektor" <idan@imperva.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the makefile I am using to create the .ko
object. Please notice that I compile my objects
by myself in a different makefile and only then
use the kbuild infrastructure. If kbuild is
adding the name as part of the module object
and not the header object then that might be
the problem. However, it is difficult for me
to use the kbuild infrastructure for the whole
build as it contains many files in different
directories.


makefile:
   
ifeq ($(KERNELRELEASE),)

PWD		:= /home/idan/my_module
KDIR	:= /usr/src/linux-$(shell uname -r)/

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

else

obj-m	:= my_module.o
my_module-objs := my_module_main.o

$(PWD)/my_module_main.o:
	echo do nothing

endif


 idan


-----Original Message-----
From: sam@ravnborg.org [mailto:sam@ravnborg.org] 
Sent: Tuesday, July 20, 2004 9:17 PM
To: Idan Spektor
Cc: linux-kernel@vger.kernel.org
Subject: Re: module name is KBUILD_MODNAME

On Tue, Jul 20, 2004 at 05:36:01PM +0200, Idan Spektor wrote:
> Hi All,
> I am migrating my loadable module to work with the 2.6 kernel.
> I have actually managed to make everything working except for
> one thing. When I am loading my module (using the new
> modprobe), its name, as appearing in lsmod, is KBUILD_MODNAME instead
> of the module's real name. What am I missing? Is there
> a define for the module's name that I should add somewhere?

For a start could you post the Makefile you use to build the module?
I assume you use the kbuild infrastructure?

	Sam
