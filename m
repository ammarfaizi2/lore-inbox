Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSBZQkS>; Tue, 26 Feb 2002 11:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291192AbSBZQkI>; Tue, 26 Feb 2002 11:40:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36084
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291084AbSBZQjx>; Tue, 26 Feb 2002 11:39:53 -0500
Date: Tue, 26 Feb 2002 08:40:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226164036.GG4393@matchmail.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB86A.7090305@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BB86A.7090305@zytor.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 08:31:38AM -0800, H. Peter Anvin wrote:
> Mike Fedyk wrote:
> >
> >Though, with a daemon checking the dirs often,
> >
> 
> Can you say "race condition?"
> 

Uhh, no.

You have a configurable size for the undelete dirs and you delete a file.
Now, that file gets moved to $mountpoint/.undelete.  The daemon gets
notified through a socket, and it can check to see if it needs to delete any
older deleted files to make sure .undelete doesn't get bigger than
configured.  

We're only scanning the dirs upon daemon startup (reminds me of
quota... ;), and all other daemon actions are triggered by unlink() writing
to a socket.  The worst thing that can happen is not seeing your free space
immediately, but a few seconds later.

Mike
