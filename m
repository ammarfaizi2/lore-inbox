Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSE3UQ7>; Thu, 30 May 2002 16:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSE3UQ6>; Thu, 30 May 2002 16:16:58 -0400
Received: from schwerin.p4.net ([195.98.200.5]:62070 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S316860AbSE3UQ5>;
	Thu, 30 May 2002 16:16:57 -0400
Message-ID: <3CF6895A.2050801@p4all.de>
Date: Thu, 30 May 2002 22:19:38 +0200
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Peter Chubb <peter@chubb.wattle.id.au>, Russel King <rmk@arm.linux.org.uk>
Subject: Re: Strange code in ide_cdrom_register
In-Reply-To: <15605.34861.599803.405864@wombat.chubb.wattle.id.au>	<3CF5D424.2060500@p4all.de> <15605.60268.673419.701625@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Peter Chubb wrote:
....
  > The cast is *wrong*, and potentially dangerous.
  >
  > I'll submit a patch....

OK. Maybe my problem is this
(in thinking - last night was definetly too short...):

---------- from ide-cd.c ------------------
static int ide_cdrom_register (ide_drive_t *drive, int nslots)
{
     struct cdrom_info *info = drive->driver_data;
     struct cdrom_device_info *devinfo = &info->devinfo;
     ...
     *(int *)&devinfo->speed = CDROM_STATE_FLAGS (drive)->current_speed;
     *(int *)&devinfo->capacity = nslots;

---------- from ide-cd.c ------------------

As you can see there are several stages of pointers:
Parameter "drive" is pointer to the original var,
"info" is a pointer to "drive->driver_data",
"devinfo" is a pointer to the address of "info->devinfo".

So we put a value into a mem-address referenced by several pointers -
but whats the type of that address? The other values are (nearly all)
just simply ints or pointers. Just putting a byte-value into a field
defined as int would probably be wrong.

But, Russel, you're right:
If we had to cast we would do it with the source.
This _is_ strange code *scratch head*  :-/

ciao

Michael



