Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUBFLS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUBFLS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:18:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265438AbUBFLSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:18:54 -0500
Date: Fri, 6 Feb 2004 11:18:53 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206111853.GE21151@parcelfarce.linux.theplanet.co.uk>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org> <pan.2004.02.06.10.19.57.885433@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.02.06.10.19.57.885433@smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 11:19:58AM +0100, Matthias Urlichs wrote:
> I've written one of those... a migration program from an old
> fixed-record-size database to SQL. Somebody had the brilliant idea to let
> two threads read the file concurrently, postprocess the thing (which took
> a variable amount of time depending on what was in the record) and then
> feed it to the database (ditto).

"Somebody made a guess about undefined behaviour"

> When that idea didn't work, I used a separate reader thread and
> coordinated buffer usage with semaphores or whatever, making the thing a
> whole lot more complicated in the process. :-/

"Guess what? It didn't work".
 
> So count me as one of those people who think that it does matter -- if N
> threads read a file of M bytes, they should collectively get M bytes from
> it (possibly out of order, of course, but that's a different problem).
> Anything else would be inconsistent.

"Please, make that undefined behaviour conform to the guess made by that
somebody.  Whaddya mean, 'non-portable' and 'broken application'?!?!?".

> Same thing goes for writing (in append mode as well as otherwise).

Look for ->i_sem use in there.
