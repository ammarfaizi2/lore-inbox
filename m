Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbRGLIPS>; Thu, 12 Jul 2001 04:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbRGLIPI>; Thu, 12 Jul 2001 04:15:08 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:63758 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267434AbRGLIPB>; Thu, 12 Jul 2001 04:15:01 -0400
Message-ID: <3B4D5BF5.22BCEAE8@namesys.com>
Date: Thu, 12 Jul 2001 12:12:37 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Ragnar =?koi8-r?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
CC: Shawn Veader <shawn.veader@zapmedia.com>, linux-kernel@vger.kernel.org,
        Nikita Danilov <god@namesys.com>
Subject: Re: disk full or not?  you decide...
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com> <20010711215413.D20990@vestdata.no>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Kjørstad wrote:
> 
> On Wed, Jul 11, 2001 at 03:30:11PM -0400, Shawn Veader wrote:
> > does anyone know why this is happening? our guess is that the logs
> > to reiser are getting quite large. how do we flush them and force
> > a garbage collection? we save and remove several large files on this
> > partition as the system is running. therefore, i figure that the
> > space is kept around till the log is flushed in case it is needed for
> > replaying the journal. am i totaly off?
> 
> No, space should be available right away, and the journal have fixed
> size (32 MB pr default)
> 
> Most likely the problem is caused by a big file (or more files) beeing
> deleted but some program still keeping it open. Then the space can not
> be reused until that program closes the file.
> 
> You can get a list of deleted files that are still open with:
> ls -l /proc/*/fd | grep deleted
> 
> --
> Ragnar Kjorstad
> Big Storage
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
this is probably due to a fixed bug addressed in a not yet released bugfix.

We are about to send it into the ac series (probably Sunday).  If you run fsck it should free up the
space, but run a backup first.

Hans
