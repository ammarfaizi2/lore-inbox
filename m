Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSJSJVT>; Sat, 19 Oct 2002 05:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265573AbSJSJVT>; Sat, 19 Oct 2002 05:21:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:64267 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265564AbSJSJVP>; Sat, 19 Oct 2002 05:21:15 -0400
Message-Id: <200210190922.g9J9M4p15225@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: jt@hpl.hp.com
Subject: 2.4.19 orinoco_cs with Lucent WaveLAN "bronze"
Date: Sat, 19 Oct 2002 14:14:57 +0000
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XKF8P0JUOYAU3X13TVER"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_XKF8P0JUOYAU3X13TVER
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi Jean,

Today I played with wireless LAN euqipment for the first time.
I have ISA-to-PCMCIA converter and a Lucent (IEEE) PCMCIA card.
I set up everything as directed by HOWTOs. I do:

# modprobe pcmcia_core
# modprobe i82365
# modprobe ds
# cardmgr -o

syslog:
=======
kernel: Linux Kernel Card Services 3.1.22
kernel:   options:  [pci] [cardbus]
kernel: Intel PCIC probe:
kernel:   Vadem VG-469 ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
kernel:     host opts [0]: none
kernel:     host opts [1]: none
kernel:     ISA irqs (scanned) = 5,9,10 status change on irq 10
cardmgr[1212]: watching 2 sockets
kernel: cs: IO port probe 0x0c00-0x0cff: clean.
kernel: cs: IO port probe 0x0800-0x08ff: clean.
kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x378-0x37f 0x4d0-0x4d7
kernel: cs: IO port probe 0x0a00-0x0aff: clean.
cardmgr[1212]: starting, version is 3.2.1
kernel: cs: memory probe 0x0d0000-0x0dffff: clean.
cardmgr[1212]: socket 0: Lucent Technologies WaveLAN/IEEE Adapter
cardmgr[1212]: executing: 'modprobe orinoco_cs'
kernel: hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
kernel: orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
kernel: orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
kernel: eth0: Station identity 00zz:00zz:00zz:00zz
kernel: eth0: Looks like a Lucent/Agere firmware version 3.04
kernel: eth0: Ad-hoc demo mode supported
kernel: eth0: MAC address zz:zz:zz:zz:zz:zz
kernel: eth0: Station name "HERMES I"
kernel: eth0: ready
kernel: eth0: index 0x01: Vcc 5.0, irq 5, io 0x0100-0x013f
cardmgr[1212]: executing: './network start eth0'
cardmgr[1212]: exiting

Then I proceed with ifconfig and tcpdump to see whether it works,
but so far I only see this in the log:

kernel: eth0: error -110 reading info frame. Frame dropped.
last message repeated 9 times
kernel: eth0: error -110 reading info frame. Frame dropped.
last message repeated 16 times
kernel: eth0: error -110 reading Rx descriptor. Frame dropped.
kernel: eth0: error -110 reading info frame. Frame dropped.
last message repeated 2 times
kernel: device eth0 entered promiscuous mode
kernel: device eth0 left promiscuous mode
kernel: device eth0 entered promiscuous mode

Maybe my signal is too weak, maybe not, I never played with Wavelan
before. Someone with cluebat?

Sometimes I see this (of course I did not remove card):

kernel: eth0: error -110 reading frame header. Frame dropped.
kernel: hermes @ IO 0x100: Card removed while issuing command.
last message repeated 165 times
last message repeated 341 times
last message repeated 54 times
kernel: eth0: Error -110 setting PROMISCUOUSMODE to 1.
kernel: eth0: Error -110 setting multicast list.
kernel: device eth0 entered promiscuous mode
kernel: hermes @ IO 0x100: Card removed while issuing command.
last message repeated 65 times

and I can't get card working without reboot after this.
I'm getting "Trying to free nonexistent resource <000003e0-000003e1>"
when I unload PCMCIA modules. Whan I try to repeat modprobe+cardmgr
sequence I see "socket 0: Anonymous Memory" which is obviously wrong.

Unabridged syslog and ifconfig/iwconfig attached for those
who wish to dig deeper.
--
vda
--------------Boundary-00=_XKF8P0JUOYAU3X13TVER
Content-Type: application/x-bzip2;
  name="syslog1.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="syslog1.log.bz2"

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

--------------Boundary-00=_XKF8P0JUOYAU3X13TVER
Content-Type: application/x-bzip2;
  name="syslog2.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="syslog2.log.bz2"

QlpoOTFBWSZTWfqApsIAA29fgGAQcO//927v3Yq/7//wUAWN6pSUKkKAACIp6hpPSDTZI9QMgZDI
0ADIAaDEOYAjBMQDAJgmjIaGATBGJhIkgE0ySeaU9GmUNHqNAepp6mnqaGRptQNDmAIwTEAwCYJo
yGhgEwRiYRSBNCFNpkyJiaanoJjUbUwR5QPSNNHpGA4gIEBI0UUgq7mlRStlRJan5oTKFau6RDJT
EOyQROc1KejXfDWZ5rCwXMMExE0EDJQfUpIl+zrMWxJSLFRPgbDSVOU+pdUJij91ojny+kBq9Zpo
8xUn2vO+5M06l9PcTAcQy/vIDtdthXIaZl0x+iChOkkbPf1HvMUDAxA4zMkp0VZCYwb48xPhPrRH
J5P8QXDLEkF1mw0LcfHzQibW223RBEQUTNtttkgU1WMyF8dDljgImpIINBSE8zMFI84EAbDkL2sc
VozKOkIP80mh6ZYY6DC3nIJFHdHdrkMx8cBInN0rS0zmwkg6BmkZ1Gcs1FwjL4d+gZWboNZNWsuJ
2LmUFnZm59uF4YycjAYLSTEKGJqKkg5UY9ZY3mZ6DYWCmJ2/pW5kIZwZmMj3QKTLEBVXqixKUBJH
BWCAH6FQahWMYxjGMYwYxjBk4VjMgUtuROdRUwJqhmZjYkmSsUFGevJqQli8kywDA7sicFRoQhPI
WEoGBB2krYoaSYpzoWCRndxQwhUgHLA1mBTnCPYTN0GAo+wzA2E5K0V2HYJznnPby2LQVAsEnxEE
vR0ptQgGVBMySoIFCiBshkgS6kxCyinQu0hUom4fDXBIyes/AO/vqeWDrsVPmFF2nzJ/xRwKF930
higRzjS5WKY7ouxCO0SFI9JdCfCcJIpYjckmLA/hynG2NPU3EDb3722/DHG9z2ebzPFbkMsDucA+
x6hR7vHkB3mZ8ix11bJNAvrP1K3KFaJ8nOsf9/rs5DdtAN7vZjrMyu4lIUfGdpqVnsesxaXINZt0
m/FCoHaUmEw2+CSEiO8Ubhm8OpwCkiA2weiz5TgIKFLFVtsFtbMlhxE9SSqDDBQqry9jMr7BHJ3x
ZNF3g3k9NzDA+IVfupQCbL0+MzrpjAnqJmBJmQqGYfjglSpoiKyNPUP2daoSND8G7kckaodD6iMU
zOng3DcqFOBoFYfSfsQBpmEjl76SlLpKFy1yHmJCHTM+rTybFeRcyz82Z6yj2cO0UfcFqs/7d7zD
5nROu98hAcplZg3FSJFNPZMJh2lJwQnJcerRGyDQW8tlQ4UOPjBSjEvO+koVAgJewxFH449EKjjc
uZHOTvSwX2DxK4mNTwIbTHdBUgwkDikEBDbUZUCgaSwidc6iFS0Eg47p0xYyfgRYnt4ebkJu0Obg
ANMlR5UOEMQNRTO1bhouxgQwQSaJIjmyajoOMkEKaByEXChi0lBs0PtN9AqJjbbMTkYI3YjqDivM
o86tJmLQUnF9muQa4zqYXC47IETMAszCaUUsSZdcJG4nGiPA0mdTEglFQkeriuayLRG4kDJsdxLX
HiwZodA0DgEWaaSJhUxFHK2atXOSodEBmXAwtFDrIalIrnYzLbYpgOZUmGBmYli5jgegoFAireHm
Oc3t3bq1NJyg4SXCajQ5hQxeBmyOWE1nYKGAFGJq4qgLPsIp4NMLP+LuSKcKEh9QFNhA

--------------Boundary-00=_XKF8P0JUOYAU3X13TVER
Content-Type: application/x-bzip2;
  name="info.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="info.bz2"

QlpoOTFBWSZTWdcJ/X4AAY9fgFUQVWP/+z/v/tA/7//wUAODw5jaABBKIImhij0m1GJppoZNBoA0
yMJptT0hocZMmTEYmAEyYJkANGEYAhgEppNRT2pDJtRoGgAAAep6g0AAAcZMmTEYmAEyYJkANGEY
AhgEkQI0EaNDQmppNP1QDBPRAAZoaTJ5QAJLIsbly1lcb5Y0tRNFSKVaFUFZOpGAgQmsaCFZ1d/F
Xqv3ZfVuemLL3R1HX6k8bHCzcIwaFIfMkghgEMLtzw8Is2JicYKTrMPoaTysRKLfK32ucEzkTHE4
2cDPsBx8zz/OYSDEqH0QGcJa7eqmS1Ka9OKDdfz0PJ4rn1fZK1GomGYMFRR7M6Sqy2ft92Zx9TB3
gwQLN8NMg1rnzxBtbn1QGqZibhjjQYPIMe8YgwSIjiIMEw0HI9wyiXRualjloMu6yydXqTcMtymw
HtWBMgYnvqUkNSkgqTEsLvbS7asF9IimqIZTnWChi9SIeU0z147khhTuEXYoGEQxuvSBfC5bzNKR
pgulMN6qwEYCk816y6EwV5q1BAPhYKmIWBRVSVSS0sO0fVdkEFYbVtaKNRyeapotJju6mLy5BuvZ
Fh0sE10E2l2dffNrhLD7Kp0Nf9SPpVGKkapBsKlpEp7+UNiCRCFm99/N1EGZk3GO3a/EmQL8NCCb
KolBBoYiiEkknGsTCDALXGZxiY+G/i6h18KJw+n8EeUfzOyD5B8opRY3Eg5uetEM6o9t408YIw7z
2iMCJf0v/rzos6D+Hzvr1EX5JWgwMwRVgYu4egHAs8Ab+EcYC9U+zkG9FJIsgBiFpzKU5l5G368C
gtuwb9Q77QLwtaxFIBlxwumiGpeUqHQn24hkVJnJY6K5ERQHDRA+tKiBi5eaAZwVlTdRE+wksw+9
YwXJVu3ytM/HGmknwrpmokAgjM6Cghkw6E1B7ziRQXqIjnTgiQmpAkS4wWxEyYwj0vyBiSi3ocZq
4HJZcIIN/2r8um5FVTDWC4MHagxC03DhPJHjAcD8875dSQP2u45cPu/5DIuCxkQm76jUNlYiYEQN
RBCuCCHnN0f54jT1xTlAoOEokB0YQq8JOM8CIEWqggJ6iIuSEpm2LQhMWT7QoLuyTTnAEiR+yP5r
zEwoguhOQ5FW9YmXpVWK4PWn4Qt/xdyRThQkNcJ/X4A=

--------------Boundary-00=_XKF8P0JUOYAU3X13TVER--
