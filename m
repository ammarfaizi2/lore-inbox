Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270355AbRHHGlF>; Wed, 8 Aug 2001 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270357AbRHHGk4>; Wed, 8 Aug 2001 02:40:56 -0400
Received: from imladris.infradead.org ([194.205.184.45]:48390 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270355AbRHHGku>;
	Wed, 8 Aug 2001 02:40:50 -0400
Date: Wed, 8 Aug 2001 07:40:56 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Mark Atwood <mra@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m3k80fv2fe.fsf@flash.localdomain>
Message-ID: <Pine.LNX.4.33.0108080729480.12565-200000@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-842912328-1802251642-997252856=:12565"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---842912328-1802251642-997252856=:12565
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Mark.

 >> I've certainly never stood in the position you call "Kernel" in
 >> that description. Here's the situation as I see it, put in those
 >> sort of terms, characters being InitScripts and Kernel
 >> respectively:
 >>
 >>  1. InitScripts points at Kernel saying "there is no good and no
 >>     well documented mapping method".
 >>
 >>  2. Kernel replies "There is a good mapping method, which is to
 >>     always map the ports starting with the lowest numbered one."

 > Well, there is that present mapping method, but I hesitate to
 > call it "good".
 >
 > Plus, we are unable to satisfactorily define "lowest numbered
 > one".

Why? When is eth0 higher numbered than eth1 for example?

 > If I build a system with several identical (other than MAC)
 > FooCorp PCI ethernics, they will number up in order of ascending
 > MAC address.
 >
 > I take the same system, replace the FooCorp cards with BarInc
 > NICs, they will number up in reverse MAC address.
 >
 > Replace them instead with Baz Systems NICs, and I get them in
 > bus scan order (at which point I'm dependent on the firmware
 > version of my PCI bridge too!).
 >
 > And if I elect to use Frob Networking NICs, I instead get them
 > in the *random* order that their oncard processors won the race
 > to power up.
 >
 > Gods and demons help me if I try putting several of all four
 > brands in one box, or the firmware on my NICs or in my PCI
 > bridges changes!

I dealt with this problem in a previous email, but will repeat it for
your benefit. The ONLY provisos I will use are the following two:

 1. All ethernet interfaces in your machine have distinct MAC's.

 2. If the firmware in your NIC's changes, the MAC's do not.

Providing both of these are met, the enclosed BASH SHELL SCRIPT
implements the `ifconfig` command with the port name replaced by its
MAC address.

With this change, it doesn't actually matter what port name a
particular interface is given, because ALL of the other network config
tools refer to the interface by its assigned IP address, not its port
name. As a result, if its port name changes between boots, the routing
automatically changes with it.

 >>  3. InitScripts then tells Kernel "But I don't want to map the
 >>    ports in ascending numerical order!"

 > The phrase "ascending numerical order" becomes, depending on if
 > you have a complex (lots of different kinds of interfaces) or
 > dynamic (ferex, with PCMCIA, CompactPCI, USB, and Firewire
 > ethernet interfaces), either useless or undefined.

I disagree: The phrase "ascending numerical order" has a FIXED
meaning, namely that eth0 comes before eth1 which comes before eth2.

You appear to have assumed that I was referring to ascending MAC
address, and such an assumption makes nonsense of most of what I said,
but if you use the meaning I used, you'll see it makes perfect sense
throughout.

Best wishes from Riley.

---842912328-1802251642-997252856=:12565
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=ifmap
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108080740560.12565@infradead.org>
Content-Description: /usr/local/sbin/ifmap
Content-Disposition: attachment; filename=ifmap

IyEvYmluL2Jhc2gNCg0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIw0KIw0KIyBUaGlzIHNjcmlwdCBwcm92aWRlcyBhIHZlcnNpb24gb2Yg
dGhlIGBpZmNvbmZpZ2AgY29tbWFuZCB0aGF0IGV4cGVjdHMgdG8NCiMgc2Vl
IHRoZSBldGhlcm5ldCBhZGRyZXNzIGFzc29jaWF0ZWQgd2l0aCBhIHBhcnRp
Y3VsYXIgcG9ydCwgYW5kIHBlcmZvcm1zDQojIHRoZSBzdGF0ZWQgYWN0aW9u
cyBvbiB3aGljaGV2ZXIgZXRoZXJuZXQgaW50ZXJmYWNlIGhhcyB0aGUgc3Bl
Y2lmaWVkDQojIGV0aGVybmV0IGFkZHJlc3MuIEFsbCBhY3Rpb25zIGFzc29j
aWF0ZWQgd2l0aCB0aGUgYGlmY29uZmlnYCBjb21tYW5kIGFyZQ0KIyBzdXBw
b3J0ZWQsIGFuZCB0aGUgb25seSBjaGFuZ2UgaW4gc3ludGF4IGlzIHRoYXQg
dGhlIHBvcnQgbmFtZSBvZiAiZXRoPyINCiMgaXMgcmVwbGFjZWQgYnkgdGhl
IGFzc29jaWF0ZWQgZXRoZXJuZXQgYWRkcmVzcy4NCiMNCiMgSWYgbm8gZXRo
ZXJuZXQgaW50ZXJmYWNlIGlzIGZvdW5kIHdpdGggdGhlIHNwZWNpZmllZCBl
dGhlcm5ldCBhZGRyZXNzLCANCiMgdGhpcyBzY3JpcHQgdXNlcyBhIHJldHVy
biB2YWx1ZSBvZiAxLCBvdGhlcndpc2UgaXQgdXNlcyBhIHJldHVybiB2YWx1
ZQ0KIyBvZiAwLg0KIw0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIw0KDQpmdW5jdGlvbiBhc3NpZ24oKSB7DQogICAgbG9jYWwgSFc9IiQx
IiBPSz1ZDQogICAgZGVjbGFyZSAtaSBOPTANCg0KICAgIHNoaWZ0IDENCiAg
ICB3aGlsZSBbICRPSyA9IFkgXTsgZG8NCglpZiAhIHBvcnQgZXRoJE4gOyB0
aGVuDQoJICAgIGlmIGlmY29uZmlnIGV0aCROIHVwIDI+IC9kZXYvbnVsbCA7
IHRoZW4NCgkJaWYgWyAiYGh3YWRkciBldGgkTmAiICE9ICIke0hXfSIgXTsg
dGhlbg0KCQkgICAgaWZjb25maWcgZXRoJE4gZG93bg0KCQllbHNlDQoJCSAg
ICBpZmNvbmZpZyBldGgkTiAiJEAiDQoJCSAgICBPSz0kPw0KCQlmaQ0KCSAg
ICBlbHNlDQoJCU9LPTANCgkgICAgZmkNCglmaQ0KCU49JE4rMQ0KICAgIGRv
bmUNCiAgICByZXR1cm4gJE9LDQp9DQoNCmZ1bmN0aW9uIGh3YWRkcigpIHsN
CiAgICBpZmNvbmZpZyAiJDEiIHwgZ3JlcCAiXiQxIiB8IHRyICcgJyAnXG4n
IHwgZ3JlcCAnWzAtOUEtRl06WzAtOUEtRl0nDQp9DQoNCmZ1bmN0aW9uIHBv
cnQoKSB7DQogICAgaWZjb25maWcgfCBncmVwIF5ldGggfCBmZ3JlcCAiJDEi
ID4gL2Rldi9udWxsDQp9DQoNCmlmIFsgJCMgLWd0IDAgXTsgdGhlbg0KICAg
IGlmIGFzc2lnbiAiJEAiIDsgdGhlbg0KCWVjaG8gTm8gZXRoZXJuZXQgaW50
ZXJmYWNlIHdpdGggYWRkcmVzcyAiJDEiIGZvdW5kLiA+JjINCglleGl0IDEN
CiAgICBlbHNlDQoJZXhpdCAwDQogICAgZmkNCmVsc2UNCiAgICBpZmNvbmZp
Zw0KICAgIGV4aXQgMA0KZmkNCg==
---842912328-1802251642-997252856=:12565--
