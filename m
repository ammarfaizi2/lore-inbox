Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVAXWmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVAXWmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVAXWlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:41:42 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:38374 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261701AbVAXWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:39:13 -0500
Message-Id: <200501242238.j0OMcru4017742@ginger.cmf.nrl.navy.mil>
To: Mike Westall <westall@cs.clemson.edu>
cc: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd) 
In-reply-to: Your message of "Mon, 24 Jan 2005 17:27:23 EST."
             <41F5764B.8050308@cs.clemson.edu> 
Date: Mon, 24 Jan 2005 17:38:54 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the author sent me the latest version of the driver and i
got it applied.  the driver does has some useful changes
along with this broken change.  i suggest udelay() since
it preserves the author's original intent.

i intend to submit a patch this week.  i probably wont
fix the ambassador since i cant test the change.

In message <41F5764B.8050308@cs.clemson.edu>,Mike Westall writes:
>You could also just revert to kernel 2.4.25 or
>earlier.  Someone who was apparently oblivious
>to the fact that device driver send routines
>were "routinely" called in irq context and/or
>that it was a <very bad thing> to call schedule()
>under such circumstances slipped that one in
>sometime between 2.4.25 which is OK and 2.4.28
>where it is broken.
>
>In 2.4.25 and earlier it was a simple busy wait loop
>in which "goto retry_here;" immediately followed
>the "if" statement.  This was safe, albeit MP unfriendly
>because of the spin_lock()/unlock() on each iteration.
>
>I'd say just delete the if and drop the damn
>packet.
>
>At any rate someone who has access to the golden code
>should fix this one way or another ASAP because its
>definitely seriously broken the way it is now.
>
>Mike
>
>
>chas williams - CONTRACTOR wrote:
>> In message <Pine.LNX.4.61L.0501210835270.6993@lt.wsisiz.edu.pl>,Lukasz Trabinsk
>> i writes:
>> 
>>>Sorry, but I don;t understand, what line, i am not kernel guru. :/
>> 
>> 
>> look for the following code:
>> 
>>            /* retry once again? */
>>             if(--retry > 0) {
>>                 schedule();
>>                 goto retry_here;
>>             }
>> 
>> 
>> change schedule() to udelay(50) and see if things are 'better'.
>> 
>> 
>>>Is was happened on 2.4.29, too. It is a interrupt problem?
>> 
>> 
>> its calling a routine that might sleep while in the transmit routine.
>> this is not allow.
>> 
>> 
>> -------------------------------------------------------
>> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>> Tool for open source databases. Create drag-&-drop reports. Save time
>> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>> _______________________________________________
>> Linux-atm-general mailing list
>> Linux-atm-general@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-atm-general
>> 
>> 
>
>
>
