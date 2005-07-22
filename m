Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVGVVUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVGVVUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVGVVUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:20:36 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:51113 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262183AbVGVVSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:18:51 -0400
Message-ID: <42E162B6.2000602@davyandbeth.com>
Date: Fri, 22 Jul 2005 16:18:46 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: select() efficiency
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive and redirect me if this is not the right place to ask 
this question:

I'm looking to write a sort of messaging system that would take input 
from any number of entities that "register" with it.. it would then 
route the messages to outputs and so forth..

I'm guessing that the messaging system would be a single process on the 
machine..

So, I'm considering making the means of input to the system be a unix 
socket.  An entity would connect to the socket as it's means of 
inputting messages into the system. 

However, lets suppose that 1000+ entities connect to that socket.. this 
would require the message system's loop to be adding 1000+ file 
descriptures to an fd_set and call select() every time it loops around 
to check for any messages.

So, my question is: how efficient would things be, doing selects() very 
often on 1000+ file descriptors?  I'm not aware of max size for an 
fd_set.. (I do know that NT is limited to 64 handles.. but that's really 
beside the point unless I look at porting someday)

Should I go another route?

The system is meant to rapidly route messages ASAP.. so it would be a 
bad idea to say write them to a file and poll the file or something like 
that...

Another thought was to use a system-wide mutex and write to a named 
pipe, but the socket method seems more appealing to me in design... and 
I didn't know if it was pretty much equivalent either way since either I 
will do the work of dealing with 1000+ things or the kernel will.

Thanks,
  Davy
