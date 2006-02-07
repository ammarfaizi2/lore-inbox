Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWBGPzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWBGPzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWBGPzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:55:22 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:50960 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S965146AbWBGPzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:55:20 -0500
Date: Tue, 7 Feb 2006 16:55:11 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Linux 2.6.15.2
Message-ID: <20060207155511.GD21873@opteron.random>
References: <19210076647.20060131153123@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19210076647.20060131153123@dns.toxicfilms.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 03:31:23PM +0100, Maciej Soltysiak wrote:
> Andrea Arcangeli's klive could some day be a measure of the bug-affected
> fraction. If it already is not. Klive reports hardware setups
> and configuration. I am not sure if it is available somehow but
> maybe it would be nice to query klive database in an SQL manner?
> 
> > SELECT COUNT(*) from hosts WHERE kernel = "2.6.15" and config_scsi = 'y'
> and ...;
> > 3089

The problem of querying with sql is just a matter of security. You can
build complex queries that may turn off a db server (I learnt the hard
way what happens with LIKE '%% preemptive %%', for whatever reason pgsql
has an heuristic that assumes long strings will be very selective in
LIKE statements and they will return very little results, but of course
it's impossible to predict that without analyzing the dataset too, in
the preemptive case lots of data is returned...).

If there's demand for the above, I'd rather prefer to export the whole
sql database and to upload it on ftp.kernel.org, so you can import it
with psql -i.  So you can import it locally and run your queries and
stats locally (anonymously too). I know this is less handy than querying
on the web, but unless you've a spare crashable box to offer, I'm not
willing to put my server at risk (also given I've commercial
applications running on it and not only KLive ;).

The KLive data is meant to be public. The website publishes most of it
already in a handy browsable form. The only thing that is private are
the ip addresses, and those should be filtered out before exporting.
