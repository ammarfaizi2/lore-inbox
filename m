Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261906AbSJDSfL>; Fri, 4 Oct 2002 14:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbSJDSfK>; Fri, 4 Oct 2002 14:35:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35203 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261906AbSJDSfJ>;
	Fri, 4 Oct 2002 14:35:09 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
To: Christoph Hellwig <hch@infradead.org>
Cc: "Mark Peloquin" <peloquin@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF57AD2670.5A531CF2-ON85256C48.006578C9@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Fri, 4 Oct 2002 13:45:04 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 02:40:37 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
>On Fri, Oct 04, 2002 at 08:34:02AM -0600, Andreas Dilger wrote:
>> On Oct 04, 2002  15:14 +0100, Christoph Hellwig wrote:
>> > > the IOCTL entry point is used to send to volumes.
>> > > the DIRECT_IOCTL entry point is used for point-
>> > > to-point ioctls between corresponding user space
>> > > and kernel space plugins.
>> >
>> > Do the ioctl directly to the device node of the lower layer plugin
instead.
>>
>> Not possible - EVMS doesn't export the lower-level device nodes at all.
>> That is one of the benefits - you can take 1000 drives and stack them
>> and raid and LVM them all you want, and you don't consume 1000*layers
>> device nodes.

>I don't think it's a benefit but really ugly.  There is no reason to now
>allow access to the lower layers.  How do I e.g. write a new volume label
to
>the lower level devices?

I am not sure I understand your question.  Did you mean that there does not
appear to be a **way** to access lower level devices or did you really mean
no reason to do so?  The reason to do so is for plug-ins such as MD which
may want to kick an array member out of the array which is a command
specific to MD.  The way in which this is accomplished in EVMS is as Mark
described above through the use of the DIRECT_IOCTL which allows for direct
communication to intermediate levels of an EVMS volume stack.

Note that this method is only used for certain cases like the MD one
described.  For normal IO type operations such as writing metadata or
changing volume labels, since EVMS in userspace knows about ALL of the
layers of the volume stack we can resolve all metadata writes to disk
relative offsets in our userspace config tools and thus don't have to write
to intermediate nodes to build more complex volumes.

Steve



