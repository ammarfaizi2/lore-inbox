Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSERMr6>; Sat, 18 May 2002 08:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSERMr5>; Sat, 18 May 2002 08:47:57 -0400
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:60032 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S312601AbSERMr5>; Sat, 18 May 2002 08:47:57 -0400
Date: Sat, 18 May 2002 13:47:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
Message-ID: <20020518134750.B2594@redhat.com>
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com> <20020517182942.GF627@matchmail.com> <20020517193410.W2693@redhat.com> <20020518013537.GH627@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 17, 2002 at 06:35:37PM -0700, Mike Fedyk wrote:
> On Fri, May 17, 2002 at 07:34:10PM +0100, Stephen C. Tweedie wrote:
> > Degraded mode relies on the parity disk being in sync at all times ---
> 
> Doesn't degraded mode imply that there are not any parity
> disk(raid4)/stripe(raid5) updates?

Nope, partity updates still occur.  It's more expensive than in
non-degraded mode, but parity still gets updated.  If it wasn't, you
would not be able to write to a degraded array at all, as updating
parity is the only way that you can write to a block which maps to a
failed disk.  By using parity, we only ever fail requests if there are
two or more failed disks in the array.

Cheers,
 Stephen
