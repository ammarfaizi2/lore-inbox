Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132835AbRDPCIr>; Sun, 15 Apr 2001 22:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132836AbRDPCIi>; Sun, 15 Apr 2001 22:08:38 -0400
Received: from relay1.pair.com ([209.68.1.20]:35854 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S132835AbRDPCI3>;
	Sun, 15 Apr 2001 22:08:29 -0400
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010416020732.30431.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: David Findlay's message of "Tue, 17 Apr 2001 08:46:12 +1000"
Organization: rows-n-columns
Date: 16 Apr 2001 12:07:31 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Findlay <david_j_findlay@yahoo.com.au> writes:

> On Monday 16 April 2001 10:40, you wrote:

> > Perhaps I misunderstand what it is exactly you are trying to do,
> > but I would think that this could be done entirely in userland by
> > software that just adds rules for you instead of you having to do
> > it manually.
> 
> I suppose, but it would be so much easier if the kernel did it
> automatically. 

Yes, but by what criteria?  You want to log on a per host basis.
Someone else wants to log by service (www, ftp, mail, news), or
any number of other criteria.

> Having a rule to go through for each IP address to be logged would
> be slower than implementing one rule that would log all of
> them. Doing this in the kernel would improve preformance.

If there really is a performance issue with a few hundred rules, then
it can be overcome by grouping rules in separate custom chains.  F.e.
if you have 1024 rules create 32 custom chains with 32 rules each.
Then have 32 rules in your main table which jump to the appropriate
custom chain --> maximum rules traversed by each packet = 64.

There is another issue with logging in general:

                *COUNTERS MUST NOT BE RESETABLE!!!*

Resetable counters guarantee that no two programs can co-exists if
they happen to reset the same counters.

All logging counters should be implemented with 32bit or 64bit
unsigned integers.  Any software using correct unsigned integer
arithmetic can then simply subtract a previous value from the current
value to get the difference.  This works reliably across counter
wrap-arounds.  There is absolutely *no need for reset* !

-- 
Manfred Bartz
---------------------------------------------------------------
ipchainsLogAnalyzer, NetCalc, whois at: <http://logi.cc/linux/>
     NEW: <http://logi.cc/linux/NetfilterLogAnalyzer.php3>

