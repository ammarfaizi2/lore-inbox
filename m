Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130230AbQKXXoX>; Fri, 24 Nov 2000 18:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130406AbQKXXoN>; Fri, 24 Nov 2000 18:44:13 -0500
Received: from jalon.able.es ([212.97.163.2]:7870 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S130230AbQKXXoC>;
        Fri, 24 Nov 2000 18:44:02 -0500
Date: Sat, 25 Nov 2000 00:13:51 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001125001351.A1342@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet> <20001123110203.EB8A8813D@halfway.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001123110203.EB8A8813D@halfway.linuxcare.com.au>; from rusty@linuxcare.com.au on Thu, Nov 23, 2000 at 12:01:53 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Nov 2000 12:01:53 Rusty Russell wrote:
> 
> What irritates about these monkey-see-monkey-do patches is that if I
> initialize a variable to NULL, it's because my code actually relies on
> it; I don't want that information eliminated.
> 

What I understood from the previous answer from Tigran is that you can
avoid initializations to ZERO or NULL, because the BSS is zeroed (ie, all
variables you declare static os global in a module are zeroed) at
kernel start.

As I understand from compiler working, if you put a statement like
int a = 0;
int b = 0;
all variables that have an initial value are stored contiguous in the
data segment of the executable and an image of their initial values has
to be stored with the binary. So if a program like

int a[16384];
int main() {}

gives a binary of 13k, if you write it as

int a[16384] = {0};
int main() {}

it has to store the 64k of a, just to put a 0 in the first place and
make the exec size to 78k.

ANSI rules for C say that uninitialized vars get a 0, but you can't trust
on the ANSI behaviour of a compiler.

Obviuosly, you have to leave your initializations to 7 or -1 in place.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
