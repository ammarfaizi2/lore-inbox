Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTBRPxF>; Tue, 18 Feb 2003 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbTBRPxF>; Tue, 18 Feb 2003 10:53:05 -0500
Received: from main.gmane.org ([80.91.224.249]:15590 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267888AbTBRPxE>;
	Tue, 18 Feb 2003 10:53:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@noln.com>
Subject: Re: [PATCH] morse code panics for 2.5.62
Date: Tue, 18 Feb 2003 11:00:23 -0500
Organization: Dis Organization
Message-ID: <b2tl9c$48c$1@main.gmane.org>
References: <20030218135038.GA1048@louise.pinerecords.com> <20030218141757.GV351@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<posted & mailed>

Jan-Benedict Glaw wrote:

> On Tue, 2003-02-18 14:50:38 +0100, Tomas Szepe <szepe@pinerecords.com>
> wrote in message <20030218135038.GA1048@louise.pinerecords.com>:
> 
> This is the first time I really look at the code, so please forgive if I
> talk about things where already a consens was given...

>> +const unsigned char morsetable[] = {
>> +    0122, 0, 0310, 0, 0, 0163,                              /* "#$%&' */
>> +    055, 0155, 0, 0, 0163, 0141, 0152, 0051,                /* ()*+,-./ */
>> +    077, 076, 074, 070, 060, 040, 041, 043, 047, 057,       /* 0-9 */
>> +    0107, 0125, 0, 0061, 0, 0114, 0,                        /* :;<=>?@ */
>> +    006, 021, 025, 011, 002, 024, 013, 020, 004,            /* A-I */
>> +    036, 015, 022, 007, 005, 017, 026, 033, 012,            /* J-R */
>> +    010, 003, 014, 030, 016, 031, 035, 023,                 /* S-Z */
>> +    0, 0, 0, 0, 0154                                        /* [\]^_ */
>> +};

> 
> You're using a set bit for long and an unset bit for a short beep, don't
> you? Storing these values in octal/as chars is quite low on memory
> consumption, but I'd like to learn so I suggest:

It's slightly more complicated than that:
It's set bits for long, unset bits for short, and termination when the byte
equals 0x01 (in other words, there's an extra set bit to the left of what
we want). This lets us represent any variable-length morse of up to 7
dits/dahs with a byte, which is cool because nothing is more than 6, that
I've ever seen.

The use of macros is an OK hack though, it reminds me of the nethack source.
:)

The reason someone proposed this in the first place is because I had had

const unsigned char * morsetable [] = {
        ".-..-.", NULL, "...-..-"

and so on in the initial revision of my patch, which is quite readable, but
takes up a lot more space, and makes the code actually a bit messier too. 

--Andrew

