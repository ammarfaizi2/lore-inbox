Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263459AbVCEAhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbVCEAhB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbVCEALW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:11:22 -0500
Received: from mx01.qsc.de ([213.148.129.14]:51658 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S263289AbVCDX2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:28:50 -0500
Message-ID: <4228EF0B.7030604@exactcode.de>
Date: Sat, 05 Mar 2005 00:28:11 +0100
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCode
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Kindtner <matthias.kindtner@t-online.de>
CC: sane-devel <sane-devel@lists.alioth.debian.org>,
       linux-kernel@vger.kernel.org
Subject: The never ending hpusbscsi storry
References: <200503050010.04190.matthias.kindtner@t-online.de>
In-Reply-To: <200503050010.04190.matthias.kindtner@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthias Kindtner wrote:

> scanimage -L
> scanimage: symbol lookup error: /usr/lib/sane/libsane-avision.so.1: undefined 
> symbol: sanei_usb_set_timeout

With the latest backed you need to update include/sane/sanei_usb.h and 
sanei/sanei_usb.c from my SVN repository (will go into SANE CVS in the 
next day).

> device `avision:/dev/sg0' is a Minolta Dimage Scan Dual II film scanner

Don't ever use hpusbscsi. I though I already told all vedors it is that 
broken that they should never ever ship it. It is the first thing that 
will be removed in Linux 2.7.

If it would be me it would be removed from _all kernels right now_ ...

> Mar  4 23:40:51 runningdug scsi: Device offlined - not ready after error 
> recovery: host 1 channel 0 id 0 lun 0
> Mar  4 23:40:51 runningdug scsi1 (0:0): rejecting I/O to offline device
> Mar  4 23:40:51 runningdug scsi1 (0:0): rejecting I/O to offline device
> Mar  4 23:40:51 runningdug scsi1 (0:0): rejecting I/O to offline device
> 
> A simple plug-out plug-in of the usb solve the problem and I can start once
> again

... hpusbscsi as it lifes ...

> I hope there are all messages you need in the mail, otherwise I send it to.
> 
> You have any Idea for me??

find /lib/modules -name hpusbscsi.*o | xargs rm -fv

(or so - assuming no spaces in filenames ...)

and build the backend with the updated sanei_usb* files. Or 
alternatively use a avision backed that is two weeks old (man svn) which 
does not need the updated sanei functionality.

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de/ | http://www.t2-project.org/
             +49 (0)30  255 897 45

