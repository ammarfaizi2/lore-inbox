Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRCFWSW>; Tue, 6 Mar 2001 17:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRCFWSM>; Tue, 6 Mar 2001 17:18:12 -0500
Received: from bucky-rwcmex.excite.com ([198.3.99.218]:55697 "EHLO
	bucky.excite.com") by vger.kernel.org with ESMTP id <S129595AbRCFWSA>;
	Tue, 6 Mar 2001 17:18:00 -0500
Message-ID: <9038100.983917051702.JavaMail.imail@digger.excite.com>
Date: Tue, 6 Mar 2001 14:17:28 -0800 (PST)
From: Thomas Hood <thood@excite.com>
Reply-To: <jdthoodREMOVETHIS@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Forcible removal of modules
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Excite Inbox
X-Sender-Ip: 199.84.63.171
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  Here's my question, with a little introduction.

Sometimes modules need to be reloaded in order
to cause some sort of reinitialization (of the
driver or of the hardware) to occur.
Sometimes this has to be done every time a machine
is suspended.  E.g., some sound driver modules
need to be reloaded after an APM suspend because
the sound chip forgets its configuration during the
suspend.  Obviously, one would like to be able to
automate the process of unloading and reloading the
modules by putting some commands in the apmd_proxy
script. Sometimes, though, "rmmod themodulename" fails
because some process is holding open a device handled
by the device driver module in question.

The solution to this is to do a "fuser" on the device
nodes associated with the device driver and kill all
the processes reported to be using those nodes.  
However, this is easier said than done because of one
problem: while you are killing a batch of processes
that are using the device node, other processes may
be opening that device node!  What is needed is a way
of preventing processes from opening a given device node.  

Now, one way of doing this is to change the device
permissions on the node to 000.  Unfortunately this does
not work well with devfs under the circumstances we have
in mind here: because once the permissions are changed
the device driver is removed; then devfs stores "000"
as the permissions that are to be used for that device
node when it is created again.

My question is: Is there some better way of blocking 
all open() calls to a particular device driver while
processes using it are being killed off?

Thomas Hood





_______________________________________________________
Send a cool gift with your E-Card
http://www.bluemountain.com/giftcenter/


