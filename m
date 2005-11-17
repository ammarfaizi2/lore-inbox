Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVKQPza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVKQPza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKQPza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:55:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61120 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932133AbVKQPza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:55:30 -0500
Date: Thu, 17 Nov 2005 16:51:51 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: =?UTF-8?Q?David_G=C3=B3mez?= <david@pleyades.net>
cc: Adrian Bunk <bunk@stusta.de>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
In-Reply-To: <20051117135731.GA11238@fargo>
Message-ID: <Pine.LNX.4.61.0511171643430.1610@scrub.home>
References: <20051116194414.GA14953@fargo> <20051116.115141.33136176.davem@davemloft.net>
 <20051116201020.GA15113@fargo> <20051116231650.GR5735@stusta.de>
 <20051117135731.GA11238@fargo>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-831893807-1132242711=:1610"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-831893807-1132242711=:1610
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 17 Nov 2005, David G=C3=B3mez wrote:

> No, the option is set. But the changes are not visible in make menuconfig=
, that
> is, i cannot select options that depend on NET_CLS_ROUTE.
>=20
> I found out that if i select NET_CLS_ROUTE4, save my changes and exit
> menuconfig, execute again make menuconfig and go to QoS options, then the=
 new
> available options are visible. So menuconfig has some problem refreshing
> contents :?

No, they were there before too, but you have to go up one level to see=20
them.

It's better in 2.6.15-rc1-git5, but the menu structure is still a little=20
messed up, the patch below properly indents all menu entries.

bye, Roman

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 net/sched/Kconfig |   37 ++++++++-----------------------------
 1 files changed, 8 insertions(+), 29 deletions(-)

Index: linux-2.6-mm/net/sched/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6-mm.orig/net/sched/Kconfig=092005-11-17 16:16:03.000000000 +01=
00
+++ linux-2.6-mm/net/sched/Kconfig=092005-11-17 16:29:46.000000000 +0100
@@ -40,9 +40,10 @@ config NET_SCHED
 =09  The available schedulers are listed in the following questions; you
 =09  can say Y to as many as you like. If unsure, say N now.
=20
+if NET_SCHED
+
 choice
 =09prompt "Packet scheduler clock source"
-=09depends on NET_SCHED
 =09default NET_SCH_CLK_JIFFIES
 =09---help---
 =09  Packet schedulers need a monotonic clock that increments at a static
@@ -98,11 +99,9 @@ config NET_SCH_CLK_CPU
 endchoice
=20
 comment "Queueing/Scheduling"
-=09depends on NET_SCHED
=20
 config NET_SCH_CBQ
 =09tristate "Class Based Queueing (CBQ)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Class-Based Queueing (CBQ) packet
 =09  scheduling algorithm. This algorithm classifies the waiting packets
@@ -120,7 +119,6 @@ config NET_SCH_CBQ
=20
 config NET_SCH_HTB
 =09tristate "Hierarchical Token Bucket (HTB)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Hierarchical Token Buckets (HTB)
 =09  packet scheduling algorithm. See
@@ -135,7 +133,6 @@ config NET_SCH_HTB
=20
 config NET_SCH_HFSC
 =09tristate "Hierarchical Fair Service Curve (HFSC)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Hierarchical Fair Service Curve
 =09  (HFSC) packet scheduling algorithm.
@@ -145,7 +142,7 @@ config NET_SCH_HFSC
=20
 config NET_SCH_ATM
 =09tristate "ATM Virtual Circuits (ATM)"
-=09depends on NET_SCHED && ATM
+=09depends on ATM
 =09---help---
 =09  Say Y here if you want to use the ATM pseudo-scheduler.  This
 =09  provides a framework for invoking classifiers, which in turn
@@ -159,7 +156,6 @@ config NET_SCH_ATM
=20
 config NET_SCH_PRIO
 =09tristate "Multi Band Priority Queueing (PRIO)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use an n-band priority queue packet
 =09  scheduler.
@@ -169,7 +165,6 @@ config NET_SCH_PRIO
=20
 config NET_SCH_RED
 =09tristate "Random Early Detection (RED)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Random Early Detection (RED)
 =09  packet scheduling algorithm.
@@ -181,7 +176,6 @@ config NET_SCH_RED
=20
 config NET_SCH_SFQ
 =09tristate "Stochastic Fairness Queueing (SFQ)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Stochastic Fairness Queueing (SFQ)
 =09  packet scheduling algorithm .
@@ -193,7 +187,6 @@ config NET_SCH_SFQ
=20
 config NET_SCH_TEQL
 =09tristate "True Link Equalizer (TEQL)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the True Link Equalizer (TLE) packet
 =09  scheduling algorithm. This queueing discipline allows the combination
@@ -206,7 +199,6 @@ config NET_SCH_TEQL
=20
 config NET_SCH_TBF
 =09tristate "Token Bucket Filter (TBF)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Token Bucket Filter (TBF) packet
 =09  scheduling algorithm.
@@ -218,7 +210,6 @@ config NET_SCH_TBF
=20
 config NET_SCH_GRED
 =09tristate "Generic Random Early Detection (GRED)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here if you want to use the Generic Random Early Detection
 =09  (GRED) packet scheduling algorithm for some of your network devices
@@ -230,7 +221,6 @@ config NET_SCH_GRED
=20
 config NET_SCH_DSMARK
 =09tristate "Differentiated Services marker (DSMARK)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y if you want to schedule packets according to the
 =09  Differentiated Services architecture proposed in RFC 2475.
@@ -242,7 +232,6 @@ config NET_SCH_DSMARK
=20
 config NET_SCH_NETEM
 =09tristate "Network emulator (NETEM)"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y if you want to emulate network delay, loss, and packet
 =09  re-ordering. This is often useful to simulate networks when
@@ -255,7 +244,6 @@ config NET_SCH_NETEM
=20
 config NET_SCH_INGRESS
 =09tristate "Ingress Qdisc"
-=09depends on NET_SCHED=20
 =09---help---
 =09  Say Y here if you want to use classifiers for incoming packets.
 =09  If unsure, say Y.
@@ -264,14 +252,12 @@ config NET_SCH_INGRESS
 =09  module will be called sch_ingress.
=20
 comment "Classification"
-=09depends on NET_SCHED
=20
 config NET_CLS
 =09boolean
=20
 config NET_CLS_BASIC
 =09tristate "Elementary classification (BASIC)"
-=09depends NET_SCHED
 =09select NET_CLS
 =09---help---
 =09  Say Y here if you want to be able to classify packets using
@@ -282,7 +268,6 @@ config NET_CLS_BASIC
=20
 config NET_CLS_TCINDEX
 =09tristate "Traffic-Control Index (TCINDEX)"
-=09depends NET_SCHED
 =09select NET_CLS
 =09---help---
 =09  Say Y here if you want to be able to classify packets based on
@@ -294,7 +279,6 @@ config NET_CLS_TCINDEX
=20
 config NET_CLS_ROUTE4
 =09tristate "Routing decision (ROUTE)"
-=09depends NET_SCHED
 =09select NET_CLS_ROUTE
 =09select NET_CLS
 =09---help---
@@ -306,11 +290,9 @@ config NET_CLS_ROUTE4
=20
 config NET_CLS_ROUTE
 =09bool
-=09default n
=20
 config NET_CLS_FW
 =09tristate "Netfilter mark (FW)"
-=09depends NET_SCHED
 =09select NET_CLS
 =09---help---
 =09  If you say Y here, you will be able to classify packets
@@ -321,7 +303,6 @@ config NET_CLS_FW
=20
 config NET_CLS_U32
 =09tristate "Universal 32bit comparisons w/ hashing (U32)"
-=09depends NET_SCHED
 =09select NET_CLS
 =09---help---
 =09  Say Y here to be able to classify packetes using a universal
@@ -345,7 +326,6 @@ config CLS_U32_MARK
=20
 config NET_CLS_RSVP
 =09tristate "IPv4 Resource Reservation Protocol (RSVP)"
-=09depends on NET_SCHED
 =09select NET_CLS
 =09select NET_ESTIMATOR
 =09---help---
@@ -361,7 +341,6 @@ config NET_CLS_RSVP
=20
 config NET_CLS_RSVP6
 =09tristate "IPv6 Resource Reservation Protocol (RSVP6)"
-=09depends on NET_SCHED
 =09select NET_CLS
 =09select NET_ESTIMATOR
 =09---help---
@@ -377,7 +356,6 @@ config NET_CLS_RSVP6
=20
 config NET_EMATCH
 =09bool "Extended Matches"
-=09depends NET_SCHED
 =09select NET_CLS
 =09---help---
 =09  Say Y here if you want to use extended matches on top of classifiers
@@ -456,7 +434,7 @@ config NET_EMATCH_TEXT
=20
 config NET_CLS_ACT
 =09bool "Actions"
-=09depends on EXPERIMENTAL && NET_SCHED
+=09depends on EXPERIMENTAL
 =09select NET_ESTIMATOR
 =09---help---
 =09  Say Y here if you want to use traffic control actions. Actions
@@ -539,7 +517,7 @@ config NET_ACT_SIMP
=20
 config NET_CLS_POLICE
 =09bool "Traffic Policing (obsolete)"
-=09depends on NET_SCHED && NET_CLS_ACT!=3Dy
+=09depends on NET_CLS_ACT!=3Dy
 =09select NET_ESTIMATOR
 =09---help---
 =09  Say Y here if you want to do traffic policing, i.e. strict
@@ -549,7 +527,7 @@ config NET_CLS_POLICE
=20
 config NET_CLS_IND
 =09bool "Incoming device classification"
-=09depends on NET_SCHED && (NET_CLS_U32 || NET_CLS_FW)
+=09depends on NET_CLS_U32 || NET_CLS_FW
 =09---help---
 =09  Say Y here to extend the u32 and fw classifier to support
 =09  classification based on the incoming device. This option is
@@ -557,11 +535,12 @@ config NET_CLS_IND
=20
 config NET_ESTIMATOR
 =09bool "Rate estimator"
-=09depends on NET_SCHED
 =09---help---
 =09  Say Y here to allow using rate estimators to estimate the current
 =09  rate-of-flow for network devices, queues, etc. This module is
 =09  automaticaly selected if needed but can be selected manually for
 =09  statstical purposes.
=20
+endif # NET_SCHED
+
 endmenu
---1463811837-831893807-1132242711=:1610--
