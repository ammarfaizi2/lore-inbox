Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbREURiA>; Mon, 21 May 2001 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbREURhu>; Mon, 21 May 2001 13:37:50 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:13201 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S261670AbREURha>; Mon, 21 May 2001 13:37:30 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Date: Mon, 21 May 2001 09:26:39 -0700 (PDT)
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.30.0105211155530.17263-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0105210925390.26948-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what makes you think it's safe to say there's only one floppy drive?

David Lang

On Mon, 21 May 2001, Oliver Xymoron wrote:

> On Sat, 19 May 2001, Alexander Viro wrote:
>
> > Let's distinguish between per-fd effects (that's what name in
> > open(name, flags) is for - you are asking for descriptor and telling
> > what behaviour do you want for IO on it) and system-wide side effects.
> >
> > IMO encoding the former into name is perfectly fine, and no write on
> > another file can be sanely used for that purpose. For the latter, though,
> > we need to write commands into files and here your miscdevices (or procfs
> > files, or /dev/foo/ctl - whatever) is needed.
>
> I'm a little skeptical about the necessity of these per-fd effects in the
> first place - after all, Plan 9 does without them.  There's only one
> floppy drive, yes? No concurrent users of serial ports? The counter that
> comes to mind is sound devices supporting multiple opens, but I think
> esound and friends are a better solution to that problem.
>
> What I'd like to see:
>
> - An interface for registering an array of related devices (almost always
> two: raw and ctl) and their legacy device numbers with a single userspace
> callout that does whatever /dev/ creation needs to be done. Thus, naming
> and permissions live in user space. No "device node is also a directory"
> weirdness which is overkill in the vast majority of cases. No kernel names
> or permissions leaking into userspace.
>
> - An unregister_devices that does the same, giving userspace a
> chance to persist permissions, etc.
>
> - A userspace program that keeps a mapping of kernel names to /dev/ names,
> permissions, etc.
>
> - An autofs hook that does the reverse mapping for running with modules
> (possibly calling modprobe directly)
>
> Possible future extension:
>
> - Allow exporting proc as a large collection of devices. Manage /proc in
> userspace on a tmpfs.
>
> --
>  "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
