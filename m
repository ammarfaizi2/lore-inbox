Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTBXWMk>; Mon, 24 Feb 2003 17:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbTBXWMk>; Mon, 24 Feb 2003 17:12:40 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:58255 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261205AbTBXWMj>; Mon, 24 Feb 2003 17:12:39 -0500
Date: Mon, 24 Feb 2003 23:21:44 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030224222144.GA27579@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com> <jeznol5plv.fsf@sykes.suse.de> <20030224215335.GA24975@gtf.org> <jeu1et5o4i.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jeu1et5o4i.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 February 2003 23:07:25 +0100, Andreas Schwab wrote:
> 
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> |> On Mon, Feb 24, 2003 at 10:35:24PM +0100, Andreas Schwab wrote:
> |> > Linus Torvalds <torvalds@transmeta.com> writes:
> |> > 
> |> > |> Does gcc still warn about things like
> |> > |> 
> |> > |> 	#define COUNT (sizeof(array)/sizeof(element))
> |> > |> 
> |> > |> 	int i;
> |> > |> 	for (i = 0; i < COUNT; i++)
> |> > |> 		...
> |> > |> 
> |> > |> where COUNT is obviously unsigned (because sizeof is size_t and thus 
> |> > |> unsigned)?
> |> > |> 
> |> > |> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
> |> > 
> |> > How can you distinguish that from other occurrences of (int)<(size_t)?
> |> 
> |> The bounds are obviously constant and unsigned at compile time.
> 
> But that's not the point.  It's the runtime value of i that gets converted
> (to unsigned), not the compile time value of COUNT.  Thus if i ever gets
> negative you have a problem.

COUNT is constant and COUNT < INT_MAX. gcc can cast the constant bound
to the variable's type to fix this problem.
Or, gcc can see that i starts with 0, it's value monotonously
increases and will never wrap around due to COUNT < INT_MAX. Not a
cheap test, but still possible.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
