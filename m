Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129766AbQK0UF1>; Mon, 27 Nov 2000 15:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129932AbQK0UFR>; Mon, 27 Nov 2000 15:05:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9600 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S129766AbQK0UFC>; Mon, 27 Nov 2000 15:05:02 -0500
Date: Mon, 27 Nov 2000 14:34:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Michael Meissner <meissner@spectacle-pond.org>,
        "David S. Miller" <davem@redhat.com>, Werner.Almesberger@epfl.ch,
        adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001127200618.A19980@athlon.random>
Message-ID: <Pine.LNX.3.95.1001127142845.2961A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Andrea Arcangeli wrote:

> On Mon, Nov 27, 2000 at 12:36:55PM -0500, Michael Meissner wrote:
> > wrong to depend on two variables winding up in at adjacent offsets.
> 
> I'd like if it will be written explicitly in the specs that it's forbidden to
> rely on that. I grepped the specs and I didn't find anything. So I wasn't sure
> if I missed the information in the specs or not. I never investigated on it
> because I always considered it bad coding regardless the fact it's guaranteed
> to generate the right asm with the _current_ tools.
> 
> Andrea
> -

The following shell-script shows that gcc-2.8.1 produces code with
data allocations adjacent. However, they are reversed!


cat - <<EOF >x.c
int a, b;
EOF
gcc -c -o x.o x.c
cat - <<EOF >y.c
extern int a;
extern int b;
int main() {
printf("a=%p\n", &a);
printf("b=%p\n", &b);
return 0;
}
EOF
gcc -o y y.c x.o
./y

a=0x804a42c
b=0x804a428

The output shows variable 'a' as being in the higher address.
So, it's not good to assume anything about so-called adjacent
variables.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
