Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSDJNKh>; Wed, 10 Apr 2002 09:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSDJNKg>; Wed, 10 Apr 2002 09:10:36 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:56569 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S312480AbSDJNKf>; Wed, 10 Apr 2002 09:10:35 -0400
Subject: Re: Event logging vs enhancing printk
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFED683A7B.D3A3294F-ONC1256B97.003BDE1C@de.ibm.com>
From: "Michael Holzheu" <HOLZHEU@de.ibm.com>
Date: Wed, 10 Apr 2002 15:08:39 +0200
X-MIMETrack: Serialize by Router on D12ML004/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 10/04/2002 15:10:21
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am currently working in the Linux/390 (mainframe) team. Our
customers usually have really large installations with dozens
of Linux images. In those scenarios it is very important to
have a good logging mechanism to do service and support system
operators in their daily work.

I tried out posix event logging (kernel and userspace) on Linux/390.
In my eyes the main benefits of posix event logging compared to the
current printk/syslog solution are:

- Additional event data is automatically logged: PID,PGRP,UID,GID,etc.
- Appropriate user space API to get this additional event data
- Better event classification: It is possible to define multiple
  facilities and event types. E.g. write out an event with
  facility=scsi and event type = 4711 (hardware malfunction)
- Event registration:
  E.g. it is possible to register callbacks to all events with
  severity=critical, facility=scsi, data contains "xyz" etc.
  If a matching log entry is written the callback is triggered.

--> Automatic processing of events is much easier than with
    the existing printk/syslog mechanism

In my last project (before Linux/390) we tried to add Unix
support to an already existing automation software on OS/390.
This software basically is an automated operator, where you
can define rules what should be done, when message xyz is written
to the event log. On OS/390 there exist APIs for event
registration and getting additional event data.
With the existing syslogd solution it was really hard or
nearly impossible to get all the required information.
If we had something like posix event in those days,
logging things would have been much easier.

Because there probably exist a lot of linux installations
which rely on syslogd and perhaps do automatic parsing of
var/log/messages in order to find out that e.g. driver x
has problems and the operator should be informed etc.,
I think it would be important to have both options:
feed printk messages into posix event logging (this does
the current patch as far as I know) AND feed events
which are written with the new posix event APIs into the
traditional syslogd logging. Perhaps this could be
configurable via kernel parameters. So nobody would be
forced to use the new functions, the printk API remains
in the kernel, operators have the choice between syslogd
and posix event logging (at least for some transitional
period)

Best Regards

       Michael

------------------------------------------------------------------------
Linux for E-Server Development
Phone: +49-7031-16-2360,  Bld 71032-03-U09
Email: holzheu@de.ibm.com


