Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266047AbRGKTym>; Wed, 11 Jul 2001 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266037AbRGKTyW>; Wed, 11 Jul 2001 15:54:22 -0400
Received: from stine.vestdata.no ([195.204.68.10]:4869 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S266013AbRGKTyW>;
	Wed, 11 Jul 2001 15:54:22 -0400
Date: Wed, 11 Jul 2001 21:54:14 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Shawn Veader <shawn.veader@zapmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disk full or not?  you decide...
Message-ID: <20010711215413.D20990@vestdata.no>
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com>; from Shawn Veader on Wed, Jul 11, 2001 at 03:30:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 03:30:11PM -0400, Shawn Veader wrote:
> does anyone know why this is happening? our guess is that the logs
> to reiser are getting quite large. how do we flush them and force
> a garbage collection? we save and remove several large files on this
> partition as the system is running. therefore, i figure that the
> space is kept around till the log is flushed in case it is needed for
> replaying the journal. am i totaly off?

No, space should be available right away, and the journal have fixed
size (32 MB pr default)


Most likely the problem is caused by a big file (or more files) beeing
deleted but some program still keeping it open. Then the space can not
be reused until that program closes the file.

You can get a list of deleted files that are still open with:
ls -l /proc/*/fd | grep deleted



-- 
Ragnar Kjorstad
Big Storage
