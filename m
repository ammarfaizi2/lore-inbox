Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269101AbRHFW4o>; Mon, 6 Aug 2001 18:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHFW4f>; Mon, 6 Aug 2001 18:56:35 -0400
Received: from imladris.infradead.org ([194.205.184.45]:60688 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269101AbRHFW4R>;
	Mon, 6 Aug 2001 18:56:17 -0400
Date: Mon, 6 Aug 2001 23:56:07 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <997127962.6478.31.camel@tduffy-lnx.afara.com>
Message-ID: <Pine.LNX.4.33.0108062304060.2845-200000@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-842912328-1984572588-997138567=:4091"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---842912328-1984572588-997138567=:4091
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Thomas.

 >> One of my systems has SIX ethernet cards, these being three ISA
 >> and two PCI NE2000 clones and a DEC Tulip. Here's the relevant
 >> section of modules.conf on the system in question:

 >>  Q> alias eth0 ne
 >>  Q> options eth0 io=0x340
 >>  Q> alias eth1 ne
 >>  Q> options eth1 io=0x320
 >>  Q> alias eth2 ne
 >>  Q> options eth2 io=0x2c0
 >>  Q> alias eth3 ne2k-pci
 >>  Q> alias eth4 ne2k-pci
 >>  Q> alias eth5 tulip

 > ok, well this makes sense for the ISA cards. I have card A in my
 > hand, I set the jumpers on it to an io port 0x340, stick it in
 > slot X on my computer, plug the wire into it from network 1,
 > then I mentally can map all the stuff together, so I know how to
 > setup the network in Linux

 > eth0 == io 0x340 == card A == slot X in my computer == network 1

 > but, how can you tell the difference between eth3 and eth4 --
 > and specify which *physical* card gets assigned to which virtual
 > eth? name...ie, how do I know which pci slot is which eth?

That depends on the driver used to map those cards. Here's what I know
so far, mainly from experimentation:

 1. The ne2k-pci driver assigns cards in ascending ethernet address
    on this machine.

 2. On the same machine, when I had three tulip cards installed, the
    tulip driver assigned them in descending ethernet address.

 3. Both of the above results are independant of the order the cards
    are plugged into the PCI bus.

As a result, there is no simple answer to your question, and the
answer above probably depends to a large extent on factors other than
the card itself.

However, if the cards are controlled by different drivers, you can
influence the order they are detected in by your choice of entries in
modules.conf - in the example above, the ISA cards are always eth0,
eth1 and eth2, the NE2k-pci cards are always eth3 and eth4, and the
tulip card is always eth5, simply because that's what the said file
says.

 > besides reading the motherboard documentation and maybe learning
 > which direction and how the pci bus is ordered...which can
 > differ between motherboard manufacturers and BIOS's, etc, etc.

Remember that every ethernet card has an ethernet address assigned to
it, this being the "HWaddr" reported by `ifconfig` and (in theory at
least) these are all unique. All you need to do is to determine the
ethernet address of each of the cards in your system, then see which
interface has that ethernet address assigned to it, and you've found
the match...

 > and how do I change it if I don't like the default order (based
 > off of pci scan order). what if I want card B, a pci card stuck
 > in PCI slot Y to be eth4?

You could always add "options eth? io=0x????" lines for the PCI ports,
and hope the addresses you've specified don't get changed, but I'll
not guarantee this works as I've never tried it.

Probably of more use is to set the IP address for a particular
interface dependant on the ethernet address of the card supplying it.
The enclosed bash script should achieve that - it's basically the
`ifconfig` command with the port name replaced by its ethernet
address, but it only works for "eth?" ports. I've tried it on my
system, and it does the job it's designed to, but YMMV...

 > I hope this is clearer...

I hope this helps...

Best wishes from Riley.


---842912328-1984572588-997138567=:4091
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=ifmap
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108062356070.4091@infradead.org>
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
---842912328-1984572588-997138567=:4091--
