Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270035AbRHQKEY>; Fri, 17 Aug 2001 06:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270036AbRHQKEP>; Fri, 17 Aug 2001 06:04:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:46859 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270035AbRHQKEH>; Fri, 17 Aug 2001 06:04:07 -0400
Message-ID: <3B7CEBD2.D3ED4D56@idb.hist.no>
Date: Fri, 17 Aug 2001 12:02:58 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre8 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Chris Schanzle <chris.schanzle@jhuapl.edu>, linux-kernel@vger.kernel.org
Subject: Re: I/O causes performance problem with 2.4.8-ac3
In-Reply-To: <3B7C08D4.9070303@jhuapl.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Schanzle wrote:
> 
> This probably belongs in the "use-once" thread...
> 
> I ran into a significant (lack of) performance situation with 2.4.8-ac3
> that does not exist with 2.4.8.  Perhaps someone can shed some light on
> what happened and how to avoid it in the future.
[...]
> In other words, system had
> cached a bunch of buffers.
> 
> Performance was excellent until I decided to "dd bs=1024k </dev/cdrom
>  >somefile" a 600+MB cdrom while a kernel build was going on.  It took
[...]
Such a big copy operation is exactly what "use-once" does well.
2.4.8 has use-once, 2.4.8ac3 don't have use-once. 

One can construct scenarios where use-once performs worse too,
I believe this is why Alan Cox didn't want it yet.  

A big copy without use-once will push everything else out of
cache, and push a lot of programs into swap in order to cache
a lot of the big copy.  That's bad if the big
copy is done once and you don't really need the stuff again.
Then you want the "other" stuff to stay in cache instead.

Use-once may perform worse if stuff falls out of cache
and has to be re-read from disk.

Helge Hafting
