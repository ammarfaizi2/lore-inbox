Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbTCZTSE>; Wed, 26 Mar 2003 14:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbTCZTSE>; Wed, 26 Mar 2003 14:18:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:36812 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261954AbTCZTSD>; Wed, 26 Mar 2003 14:18:03 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       <samel@mail.cz>, <ma@dt.e-technik.uni-dortmund.de>
Subject: Re: BK-kernel-tools/shortlog update
References: <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Wed, 26 Mar 2003 20:25:35 +0100
In-Reply-To: <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com> (Linus
 Torvalds's message of "Wed, 26 Mar 2003 09:21:22 -0800 (PST)")
Message-ID: <87brzy0w28.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Wed, 26 Mar 2003, Matthias Andree wrote:
>> 
>> you can either use bk receive to patch this mail, you can pull from
>> bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
>> or you can apply the patch below.
>
> Btw, one feature I'd like to see in shortlog is the ability to use 
> regexps for email address matching, ie something like
>
> 	'torvalds@.*transmeta.com' => 'Linus Torvalds'
> 	... 
> 	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
> 	...
> 	'bcrl@redhat.com' => 'Benjamin LaHaise',
> 	'bcrl@.*' => '?? Benjamin LaHaise',
> 	..
>
> I don't know whether you can force perl to do something like this, but if 
> somebody were to try...

if you change your list to:

@email_name_map = (
	['torvalds@.*transmeta.com' => 'Linus Torvalds'],
	... 
	['alan@.*swansea.linux.org.uk' => 'Alan Cox'],
	...
	['bcrl@redhat.com' => 'Benjamin LaHaise'],
	['bcrl@.*' => '?? Benjamin LaHaise'],
...);

something along these (untested) lines should do the trick:

sub email2name
{
	my($email) = @_;
	for my $i (@mailmap) {
		my($pattern, $name) = @$i;
		return $name if ($email =~ m/$pattern/i);
	}

	return '??';
}
      
Regards, Olaf.
