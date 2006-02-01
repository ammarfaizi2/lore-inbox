Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWBAEuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWBAEuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWBAEuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:50:00 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:33587 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964915AbWBAEt7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:49:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oke0A6cY/tlJeOQKOTLT204s5g6ZWb096jda8WROvnJw4eBbmArrl5M/bilSfpGPL3LWV/UfXcADWD/1PdocjZleD2tqUGQ91xc23Q52MiBL8h8jWQ6pENOza08tjKIE3RT9B+8CvH1wQ22FLfGTN+fo90iK9oB1jA+m3lT5GPU=
Message-ID: <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com>
Date: Tue, 31 Jan 2006 23:49:58 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: CD writing in future Linux try #2
Cc: gmack@innerfire.net, diablod3@gmail.com, schilling@fokus.fraunhofer.de,
       bzolnier@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060131.031817.85883571.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601302043.56615.diablod3@gmail.com>
	 <20060130.174705.15703464.davem@davemloft.net>
	 <Pine.LNX.4.64.0601310609210.2979@innerfire.net>
	 <20060131.031817.85883571.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, David S. Miller <davem@davemloft.net> wrote:

> Someone remind me why the whole world is a prisoner to Joerg's cd
> burning program?
>
> Anybody can write their own, and if Joerg is a pain to work with that
> is a double extra incentive for this other implementation to be
> written.
>
> In fact I'm very surprised this hasn't happened already.

It has happened, many times, but sustaining such a project is
very difficult. The obstacles are numerous:

All the GUI apps parse cdrecord output. The output is somehow
even messier than the recent /proc/*/smaps abomination. It is
thus difficult to change or replace cdrecord. One of the major
GUI apps appears to be written by Joerg's real-life non-Internet
friend, who naturally refuses any patches to eliminate the need
for cdrecord.

Joerg is a Fraunhofer employee. That gives him connections to
many hardware companies. (and the RIAA, MPAA, Sony, Disney...)
One may wonder if this is both blessing and curse.

Forking means dealing with a giant pile of messy and ugly code.
The coding conventions are... interesting... and this code has
to run setuid. One had better be really careful making changes.
Most people are clueless about setuid code.

Starting fresh means rediscovering firmware bugs, of which there
are many. Things may be getting somewhat better though, with the
old pre-standard interfaces hopefully dying out. Getting the most
out of the hardware will require lots of device-specific code.

Joerg gets the hardware.

There are all sorts of funky formats. I've only ever heard of
mixed audio+data CDs for circa-1995 games and Sony spyware, but
maybe there are decent people who actually create these things.
In theory, somebody might be making multi-session CDs. Who knows?

That all said, I just wrote /dev scan code and I'm about half
way through documenting xcdroast's cdrecord expectations.
I'm imagining something like this:

/usr/lib/burner-helper: setuid or daemon, controlled via stdio
/usr/lib/something.so:  interacts with burner-helper
/usr/bin/cdrecord:      the crappy legacy interface
/usr/bin/something:     a non-crappy CLI interface

(no promises)
