Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264592AbRFYOuT>; Mon, 25 Jun 2001 10:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264589AbRFYOuJ>; Mon, 25 Jun 2001 10:50:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9346 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264593AbRFYOtu>; Mon, 25 Jun 2001 10:49:50 -0400
Date: Mon, 25 Jun 2001 10:49:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Shutko <ats@acm.org>
cc: Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <87ofrcbryf.fsf@wesley.springies.com>
Message-ID: <Pine.LNX.3.95.1010625094914.7314A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Alan Shutko wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > This means that it must be some place else than where it's denoted
> > in a visual representation of the structure.
> 
> No, that's not true.
> 
> ISO/IEC 9899:1990 6.5.2.1:
> 
>   As discussed in 6.1.2.5, a structure is a type consisting of a
>   sequence of named members, whose storage is allocated in an ordered
>   sequence, and a union [stuff we don't care about].
>

Does "ordered sequence" mean "incremental"? I think not.
 
>   Within a structure object, the non-bit-field members and the units
>   in which bit-fields reside have addresses that increase in the order
>   in which they declared.


Really?? Did you TYPE this in or did you copy it from somewhere??
When I was on an ANSI committee (nothing to do with software), we
made damn sure that we used the correct English.

Look at:
 "have addresses that increase in the order in which they declared."

I think this was added, in the copy you cite, by somebody who didn't
know English grammar, to support the argument..."

 "in which they were declared."
                ^^^^

And... If this was a part of a C specification it would prevent
the inclusion of const data within a structure unless the entire
structure was of type const. And, it is well known that any
data types may be structure members so this cannot be correct.

    A pointer to a structure object, suitably
>   converted, points to its initial member (or if that member is a
>   bit-field, then to the unit in which it resides, and vice versa.
>   There may therefore be unnammed padding withing a structure object,
                           ^^^^^^^^         ^^^^^^^

Unnamed and within are spelled incorrectly. This is not a valid
document.


>   but not at its beginning, as necessary to achieve the appropriate
>   alignment.
> 
>   There may also be unnamed padding at the end of a structure or
>   union, as necessary to achieve the appropriate alignment were the
>   structure or union to be an element of an array.
>
 
> You can look at other things too... you can memcpy structures, pass
> them into functions, call sizeof, put them in arrays... it _is_ a
> physical representation.
> 

memcpy()...
Maybe you can memcpy() structures. Maybe you and I usually get away
with it, but provisions were made to handle the problems previously
discussed, by using the assigment operator "=" to copy structures.
This way, the compiler "knows" where things are and handles duplication
accordingly. And copying a structure that contains a mix of const
and writable data is probably a bug since the copy can't support
data of type 'const'.

Pass to functions...
Since any memory object(s) including structure members are simply
data contained at addresses, of course you can pass them to functions
although doing this is probably done by mistake, rather than design.
Generally, one would pass a pointer to a structure. Which, according
to previously-cited rules, represents the address of the first structure
member.

"call?" sizeof...
Returns the allocation size of the structure. So? The compiler
can certainly add up the length of all the structure members plus
any padding and return the result. Note that you can't allocate data
of type 'const' so when copying any structure by any means, the
copy contains no 'const' data, even if the original structure contained
'const' data members. The const data is/are not missing, they are
just no longer const.

Put into arrays...
Of course. Nothing has to be physical representation as a requisite
for being put into arrays.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


