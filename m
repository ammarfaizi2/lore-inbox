Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267960AbTAHUO5>; Wed, 8 Jan 2003 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbTAHUO5>; Wed, 8 Jan 2003 15:14:57 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:50752 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267960AbTAHUOV>; Wed, 8 Jan 2003 15:14:21 -0500
Message-ID: <3E1C889F.70303@users.sf.net>
Date: Wed, 08 Jan 2003 21:22:55 +0100
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David D. Hagood" <wowbagger@sktc.net>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net>
In-Reply-To: <3E1C1CDE.8090600@sktc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood wrote:

> The basic idea is that you have 8 filters (for the 4 row and 4 column 
> frequencies), as well as 8 filters looking at the first harmonic of the 
> 8 frequencies. You then compare the energies in each frequency - if you 
> see significant energy in the harmonic filter bank, discard the signal. 
> That prevents you from detecting speech as DTMF, since speech will 
> usually have harmonics that a good DTMF signal won't.

The original idea does one better by splitting high and low bands first. If that 
is combined with Goertzel it might be even better: by looking at how much low 
band energy there is total versus the low detected tone, and the same for the 
high band total versus the high band detected tone. Only if the detected tone is 
sufficiently strong compared to the total band it is in should the tone be 
triggered.

But it may be more expensive computationally than doing twice the number of 
Goertzel filters.

Harmonics seem like a bad idea. In between frequencies are better, but using the 
total band energy must be the most sure way to detect interference.


Thomas

