Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293703AbSCPFNH>; Sat, 16 Mar 2002 00:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293708AbSCPFM5>; Sat, 16 Mar 2002 00:12:57 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:5901 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S293703AbSCPFMk>; Sat, 16 Mar 2002 00:12:40 -0500
To: frankeh@watson.ibm.com
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] get_pid() performance fix
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
	<20020314231733.638C03FE06@smtp.linux.ibm.com>
	<87663xlv33.fsf@devron.myhome.or.jp>
	<20020315183610.212993FE06@smtp.linux.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 16 Mar 2002 14:12:16 +0900
In-Reply-To: <20020315183610.212993FE06@smtp.linux.ibm.com>
Message-ID: <87zo19jdu7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> On Friday 15 March 2002 10:16 am, OGAWA Hirofumi wrote:
> > Whoops! I'm sorry. previous email was the middle of writing.
> >
> > Hubertus Franke <frankeh@watson.ibm.com> writes:
> > > +	if (i == PID_MAP_SIZE) {
> > > +		if (again) {
> > > +			/* we didn't find any pid , sweep and try again */
> > > +			again = 0;
> > > +			memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
> > > +			last_pid = RESERVED_PIDS;
> > > +			goto repeat;
> > > +		}
> > > +		next_safe = RESERVED_PIDS;
> > > +		return 0;
> >
> > Probably, the bug is here. No bug ....
> 
> >
> >   +	next_safe = RESERVED_PIDS;	/* or 0 */
> >
> > > +	read_unlock(&tasklist_lock);
> > > +	spin_unlock(&lastpid_lock);
> > > +	return 0;
> > >  }
> >
> > Basically nice, I think.
> >
> > BTW, How about using the __set_bit(), find_next_zero_bit(), and
> > find_next_bit() in get_pid_by_map().
> >
> > Thanks for nice work.
> 
> OGAWA, honestly I only tried testcase 2.
> But looking at your suggestion its not clear to me whether
> there is a bug.
> Remember we need to determine a valid interval [ last_pid .. next_safe ).
> In the pid_map function, if no pid is available, then
> [ PID_MAX .. PID_MAX ) will be returned.
> The other path should also end up with this as well.
> Could you  point where you see this not happening.

Maybe my point was unclear. Sorry.

Please consider what happens after using up pid. Then,
get_pid_by_map() returns 0.

And last_pid = 0, next_safe = RESERVED_PIDS.  After it, get_pid()
returns the values between 0 and RESERVED_PIDS.

And the line which I added is also the same reason. 

Regards.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
