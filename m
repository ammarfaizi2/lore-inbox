Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUEEL4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUEEL4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUEEL4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:56:19 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:23256 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264569AbUEEL4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:56:15 -0400
Message-ID: <4098D65D.9010107@free.fr>
Date: Wed, 05 May 2004 13:56:13 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040501
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with some
 object code only
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The Changelog says nothing really important but forcing REGPARAM is 
rather important : it breaks any external module using object only code 
that calls a kernel function.

I do not want to enter the "binary module" debate just reports facts so 
that people be aware of the problem.

I have a bewan PCI ST ADSL modem. They provide a linux driver that works 
with 2.6 like a charm but contains an object file. And of course code 
located in this object only file breaks because it calls alloc_obj:

alloc_obj:kmalloc failed,size=-742088876,type=abc0

Complete stack trace attached... (that shows they do not expect kmalloc 
to fail :-( )

Do not blame Bewan  : they have always been very responsive and do 
provide an almost GPL compliant module that works with 2.4 and 2.6 
kernels like a charm. In particular, fixing the code to support 2.6 
module generation scheme has only taken in a couple of weeks after I 
politely asked to the maintainer sending an initial patch. They are just 
dependent on STMicro (if I remember correctly) for the library that 
drives the ATM chipset and apparently they failed to ask them to open up 
their code...

Maybe they can just ask them to compile with regpram=3 but anyway as an 
end-user I have no solution...

I will report the bug to my contact...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



