Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTANURU>; Tue, 14 Jan 2003 15:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTANURU>; Tue, 14 Jan 2003 15:17:20 -0500
Received: from tantale.fifi.org ([216.27.190.146]:14745 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265197AbTANURT>;
	Tue, 14 Jan 2003 15:17:19 -0500
To: root@chaos.analogic.com
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 14 Jan 2003 12:25:54 -0800
In-Reply-To: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
Message-ID: <87iswrzdf1.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Tue, 14 Jan 2003, DervishD wrote:
> 
> >     Hi all :))
> > 
> >     I'm not sure whether this issue belongs to the kernel or to the
> > libc, but I think that is more on the kernel side, that's why I ask
> > here.
> > 
> 
> Last time I checked argv[0] was 512 bytes. Many daemons overwrite
> it with no problem.

Last time must have been in an alternate reality.

You just overwrote all your arguments (argv[0] and others) and part of
the environment.

Try this for a change:

#include <stdio.h>
#include <string.h>
extern char ** _environ;
int main(int cnt, char *argv[]) {
    char **eptr;
    for ( eptr = _environ; *eptr; ++eptr )
        printf("ENV before: %s\n", *eptr);
    strcpy(argv[0], "How-long-do-you-want-this-string-to-be?--is-this-long-enough?");
    for ( eptr = _environ; *eptr; ++eptr )
        printf("ENV after: %s\n", *eptr);
    pause();
    return 0;
}

Phil.
