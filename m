Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWAYC6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWAYC6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 21:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWAYC6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 21:58:38 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:15239 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750980AbWAYC6f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 21:58:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cgVfGQhrTtRr3q0HSX517dDhHaz9ZEUPS+nh3trIVPConcN9RRco4k8CJSD75ULvM5EMze1f+HguZdJICq0pfxKVSZiIGc6cel+Pgx1Mq88B5yZYnG7R6jG2Pqt7p0BJlAs+nMQmEJsHhR+/jRiU4S8h+hQRoE1hehJMmqVGwb8=
Message-ID: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
Date: Tue, 24 Jan 2006 21:58:34 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de,
       rlrevell@joe-job.com, matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling writes:
> Matthias Andree <matthias.andree@gmx.de> wrote:

>> S3 Device enumeration/probing is a sore spot. Unprivileged
>> "cdrecord dev=ATA: -scandisk" doesn't work, and recent
>> discussions on the cdwrite@ list didn't make any progress.
>> My observation is that cdrecord stops probing /dev/hd* devices
>> as soon as one yields EPERM, on the assumption "if I cannot
>> access /dev/hda, I will not have sufficient privilege to
>> write a CD anyways". I find this wrong, Joerg finds it correct
>> and argues "if you can access /dev/hdc as unprivileged user,
>> that's a security problem".
>
> This are two problems:
>
> -     users of cdrecord like to run cdrecord -scanbus in order
>       to find all SCSI devices. This no longer works since the
>       non-orthogonal /dev/hd* SCSI transport has been added.
>
>       As Linux already implements a Generic SCSI transport
>       interface (/dev/sg*) people would asume to be able to
>       talk to _all_ SCSI devices using this interface.
>       To allows this, there is a need for a SCSI HBA driver
>       that sends SCSI commands via a ATA interface.
>
> -     some people seem to set the permissions of some of the
>       /dev/hd* nodes to unsafe values and then complain that
>       the other /dev/hd* nodes cannot be opened.

**sigh**

Matthias Andree said "(Joerg, please don't talk about layer
violations here)", yet you do.

We Linux users will forever patch your software to work the
way every Linux app is supposed to work. (well, assuming
nobody succumbs to a well-caffeinated urge to fork the code)

Really, "users of cdrecord like to run cdrecord -scanbus"???
They LIKE running a command to generate phony SCSI addresses?
That's news to me.

To better protect users from terrible accidents, Linux should
avoid assigning a /dev/sg* device for anything with a regular
device file. This, along with elimination of the obsolete
ide-scsi crud, would make things a lot more safe and sane.

BTW, before Joerg mentions portability, I'd like to remind
everyone that all modern OSes support the use of normal device
names for SCSI. The most awkward is FreeBSD, where you have
to do a syscall or two to translate the name to Joerg's very
non-hotplug non-iSCSI way of thinking. Windows, MacOS X, and
even Solaris all manage to handle device names just fine. In
numerous cases, not just Linux, cdrecord is inventing crap out
of thin air to satisfy a pre-hotplug worldview.
