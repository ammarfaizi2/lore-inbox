Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUIFHcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUIFHcp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUIFHcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:32:45 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:25256 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S267359AbUIFHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:32:40 -0400
Date: Mon, 06 Sep 2004 07:32:39 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: Backlight and LCD module patches [2]
In-reply-to: <20040905150032.GF12701@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1094455959l.4240l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-3, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.5.0, SenderIP=146.151.41.63
References: <20040617223517.59a56c7e.zap@homelink.ru>
 <20040725215917.GA7279@hydra.mshome.net> <20040813232739.GB5063@kroah.com>
 <1093056693l.30570l.0l@hydra> <20040905150032.GF12701@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/04 10:00:32, Greg KH wrote:
> On Sat, Aug 21, 2004 at 02:51:33AM +0000, John Lenz wrote:
> >
> > Here.  A few notes on the implementation.  I have a global lock
> protecting
> > all match operations because otherwise we get a dining philosophers
> problem.
> > (Say the same class is in two class_match structures, class1 in the
> first
> > one and class2 in the second...)
> 
> You also have some duplicated code in one function, which implies that
> you didn't test this patch (it's in the updated patch you sent me too) :)

I didn't test it.  It was only to show what I was thinking of with  
class_match.

> 
> > The bigger question of how should we be linking these together in the
> first
> > place?
> 
> I thought you only wanted the ability to actually find the different
> class devices.  Then the code would take it from there.  Not this
> complex driver core linking logic that you implemented.
> 
> > Instead of using this class_match stuff, we could use class_interface.
> 
> Exactly.  Why don't you all use that instead?

The only benifit from class_match is the "object oriented approach".  I  
assume that the struct list_head children in struct class can be used from  
driver code?  It is the correct policy to use that directly than to call a  
function in class.c?  As well, the struct kobject in class_device (which we  
would use to create a symbolic link)?  And of course our driver code would  
have to acquire class->subsys.rwsem...

If we do it in lcdbase.c we can even solve the locking problem... that is,  
we can always acquire class->subsys.rwsem in the lcd class before the  
class->subsys.rwsem in fb_class.

John

