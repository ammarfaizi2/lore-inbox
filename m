Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRECW7c>; Thu, 3 May 2001 18:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRECW7M>; Thu, 3 May 2001 18:59:12 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:55824 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135353AbRECW7E>;
	Thu, 3 May 2001 18:59:04 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard 
In-Reply-To: Your message of "Thu, 03 May 2001 12:59:21 -0400."
             <20010503125921.A347@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 May 2001 08:58:58 +1000
Message-ID: <22710.988930738@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001 12:59:21 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Keith Owens <kaos@ocs.com.au>:
>>         (3) For failing constraints, freeze the guard variables, change
>>             the dependent variable to satisfy the constraint then
>>             freeze it.
>
>There's the problem.  You don't know which variable(s) are dependent.
>That's not a well-defined notion here.  Consider the case that stimulated
>this whole argument:
>
>	(X86 and SMP) implies RTC!=n
>
>You think you know that RTC is 'dependent', but this is an illusion created
>by the presence of the asymmetrical `implies'.  Go look at the hierarchy.
>You'll see what I mean.

On the contrary, I know what the hierarchy says and I also know that
that implies is normally bidirectional.  In the case of batch mode,
where you cannot ask the user to solve the violation, I suggest that
CML2 treat implies as unidirectional, but only for this case.

IOW, the order of the constraints (not the hierarchy) and the ordering
of the guard and dependent variables in each constraint are hints by
the rules writer to CML2 about which variables are more important.
Earlier constraints are more important than later ones.  Guard
variables are more important that dependent variables.

So when CML2 reaches the end of a batch config run and has a violation
on 'require X86 and SMP implies RTC!=n', X86 and SMP will not be
considered for changing, RTC will be.  Using hints from the order of
the constraints reduces the solution space from 3^1957 to 2.

