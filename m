Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293675AbSCFQ5c>; Wed, 6 Mar 2002 11:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293681AbSCFQ5X>; Wed, 6 Mar 2002 11:57:23 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:41355 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S293675AbSCFQ5O> convert rfc822-to-8bit;
	Wed, 6 Mar 2002 11:57:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Removable IDE devices problem
Date: Wed, 6 Mar 2002 18:57:11 +0200
Message-ID: <FC5FF66A769AB044AED651C705EAA8EA67A9DA@esebe008.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Removable IDE devices problem
Thread-Index: AcHFL/WyKpLl88CHR5uR7CcJePanqA==
From: <marko.kohtala@nokia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Mar 2002 16:57:12.0085 (UTC) FILETIME=[F5C99C50:01C1C52F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about the struct ide_drive_s member removable.

The problem with it is that I have an IDE flash disk that sits on normal IDE bus and this removable flag gets set because the IDE ID info has the bit set for removable. Because this flag is set, idedisk_media_change will return true every time media change check is done. This happens every time when partitions are being mounted.

Now, because idedisk_media_change tells the media is changed, the system invalidates all buffers. This is bad when the dirty buffers on some of the partitions have not been written to the disk. Data is lost and file system is corrupt.

I suppose the device tells it is removable because the controller on the disk is also used with some PCMCIA IDE devices.

I am curious if this idedisk_media_change return value is needed with some removable disks. I do not know any. I think that in case of a PCMCIA, the whole IDE controller is removed and that should invalidate all buffers.

Currently I have just patched the kernel to clear the flag for this particular disk.

But I'd need your help in finding a real fix to the problem.
