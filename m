Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132947AbRDERjv>; Thu, 5 Apr 2001 13:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRDERjk>; Thu, 5 Apr 2001 13:39:40 -0400
Received: from jalon.able.es ([212.97.163.2]:1764 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132947AbRDERj3>;
	Thu, 5 Apr 2001 13:39:29 -0400
Date: Thu, 5 Apr 2001 19:38:40 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Andreas Schwab <schwab@suse.de>
Cc: Joseph Carter <knghtbrd@debian.org>, Bart Trojanowski <bart@jukie.net>,
        "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
Message-ID: <20010405193840.A5365@werewolf.able.es>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER> <Pine.LNX.4.30.0104050901500.13496-100000@localhost> <20010405072628.C22001@debian.org> <jevgojiew7.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <jevgojiew7.fsf@hawking.suse.de>; from schwab@suse.de on Thu, Apr 05, 2001 at 16:45:44 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.05 Andreas Schwab wrote:
> 
> Try this and watch your compiler complaining:
> 
> #define foo() { }
> #define bar() do { } while (0)
> void mumble ()
> {
>         if (1) foo(); else bar();
>         if (2) bar(); else foo();
> }
> 

Perhaps it is time to USE gcc, yet the kernel can be built only with gcc.
IE, use statement expressions.

Try this:

#define foo() ({ })
#define bar() do { } while (0)
void mumble ()
{
	if (1) foo(); else bar();
	if (2) bar(); else foo();
}

and see you compiler shutup.
You can even declare vars inside the ({ ... }) block,
so all the

#define bar(x) do { use_1(x); use_2(x); } while (0)

could be written like:

#define bar(x) ({ use_1(x); use_2(x); })

Even you can use <typeof>:

#define swap(a,b) \
({ typeof(a) tmp = a; \
   a = b; \
   b = tmp; \
})

int main()
{
	int a,b;
	double c,d;
	
	swap(a,b);
	swap(c,d);
}

Its correct in egcs-1.1.2 and up, so it is safe for use in kernel 2.4.
Do not know if previuous gcc eats it up.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

