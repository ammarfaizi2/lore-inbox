Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293681AbSCFRPC>; Wed, 6 Mar 2002 12:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSCFROw>; Wed, 6 Mar 2002 12:14:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:15626 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293681AbSCFROh>; Wed, 6 Mar 2002 12:14:37 -0500
Message-ID: <3C864E44.7030008@evision-ventures.com>
Date: Wed, 06 Mar 2002 18:13:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: marko.kohtala@nokia.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Removable IDE devices problem
In-Reply-To: <FC5FF66A769AB044AED651C705EAA8EA67A9DA@esebe008.NOE.Nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marko.kohtala@nokia.com wrote:
> I have a question about the struct ide_drive_s member removable.
> 
> The problem with it is that I have an IDE flash disk that sits on normal IDE bus and this removable flag gets set because the IDE ID info has the bit set for removable. Because this flag is set, idedisk_media_change will return true every time media change check is done. This happens every time when partitions are being mounted.
> 
> Now, because idedisk_media_change tells the media is changed, the system invalidates all buffers. This is bad when the dirty buffers on some of the partitions have not been written to the disk. Data is lost and file system is corrupt.
> 
> I suppose the device tells it is removable because the controller on the disk is also used with some PCMCIA IDE devices.
> 
> I am curious if this idedisk_media_change return value is needed with some removable disks. I do not know any. I think that in case of a PCMCIA, the whole IDE controller is removed and that should invalidate all buffers.
> 
> Currently I have just patched the kernel to clear the flag for this particular disk.
> 
> But I'd need your help in finding a real fix to the problem.

Your analysis of the problem is entierly right, since the current
kernel behaviour for removable media is supposed to work for
floppies (never get this thing out of your computer
as long as long the diode blinks) or read only media where it doesn't
really matter. However I still don't see a good way to
resolve this issue. (Maybe just adding buffer cache flush before
going into the check_media_change business of "grocking" partitions
would be sufficient...

