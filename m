Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129434AbQKYXQ5>; Sat, 25 Nov 2000 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130134AbQKYXQs>; Sat, 25 Nov 2000 18:16:48 -0500
Received: from hera.cwi.nl ([192.16.191.1]:7672 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129434AbQKYXQk>;
        Sat, 25 Nov 2000 18:16:40 -0500
Date: Sat, 25 Nov 2000 23:46:24 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001125234624.A7049@veritas.com>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011252211.eAPMBIo21200@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Sun, Nov 26, 2000 at 09:11:18AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 09:11:18AM +1100, Herbert Xu wrote:

> No information is lost.

Do I explain things so badly? Let me try again.
The difference between

  static int a;

and

  static int a = 0;

is the " = 0". The compiler may well generate the same code,
but I am not talking about the compiler. I am talking about
the programmer. This " = 0" means (to me, the programmer)
that the correctness of my program depends on this initialization.
Its absense means (to me) that it does not matter what initial
value the variable has.

This is a useful distinction. It means that if the program

  static int a;

  int main() {
	  /* do something */
  }

is used as part of a larger program, I can just rename main
and get

  static int a;

  int do_something() {
	  ...
  }

But if the program

  static int a = 0;

  int main() {
	  /* do something */
  }

is used as part of a larger program, it has to become

  static int a;

  int do_something() {
	  a = 0;
	  ...
  }


You see that I, in my own code, follow a certain convention
where presence or absence of assignments means something
about the code. If now you change "static int a = 0;"
into "static int a;" and justify that by saying that it
generates the same code, then I am unhappy, because now
if I turn main() into do_something() I either get a buggy
program, or otherwise I have to read the source of main()
again to see which variables need initialisation.

In a program source there is information for the compiler
and information for the future me. Removing the " = 0"
is like removing comments. For the compiler the information
remains the same. For the programmer something is lost.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
