Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267858AbTAHMeq>; Wed, 8 Jan 2003 07:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbTAHMeq>; Wed, 8 Jan 2003 07:34:46 -0500
Received: from oak.sktc.net ([208.46.69.4]:9605 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S267858AbTAHMep>;
	Wed, 8 Jan 2003 07:34:45 -0500
Message-ID: <3E1C1CDE.8090600@sktc.net>
Date: Wed, 08 Jan 2003 06:43:10 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Tonino <ttonino@users.sourceforge.net>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net>
In-Reply-To: <3E1BD88A.4080808@users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Tonino wrote:
> Roy Sigurd Karlsbakk wrote:
> 
>> so - we DO NOT need a 'simplistic' DTMF decoder.
> 
> 
> You need a good one. But good can be simplistic, is what I'm saying.
> 
> DTMF was designed to be easy to decode reliably. Complex doesn't 
> automatically mean better.
> 

I haven't looked at the code, but I'd recommend using a bank of Goertzel 
filters -


http://www.google.com/search?hl=en&lr=&ie=ISO-8859-1&q=Goertzel+filter+DTMF&btnG=Google+Search

The basic idea is that you have 8 filters (for the 4 row and 4 column 
frequencies), as well as 8 filters looking at the first harmonic of the 
8 frequencies. You then compare the energies in each frequency - if you 
see significant energy in the harmonic filter bank, discard the signal. 
That prevents you from detecting speech as DTMF, since speech will 
usually have harmonics that a good DTMF signal won't.

Since the Goertzel filters are simple, they can be implemented in fixed 
point math rather than floating point. At work, we've done this on a 
Motorola 56301 DSP, which is a fixed-point DSP. I think there's an app 
note from Moto on this - I'll check when I get into work today.

