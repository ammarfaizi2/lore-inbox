Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318841AbSHETEa>; Mon, 5 Aug 2002 15:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSHETE3>; Mon, 5 Aug 2002 15:04:29 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:43956
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S318841AbSHETDf>; Mon, 5 Aug 2002 15:03:35 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200208051906.g75J6d122986@www.hockin.org>
Subject: Re: ethtool documentation
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 5 Aug 2002 12:06:39 -0700 (PDT)
Cc: abraham@2d3d.co.za (Abraham vd Merwe),
       linux-kernel@vger.kernel.org (Linux Kernel Development)
In-Reply-To: <3D4E9CE4.8060808@mandrakesoft.com> from "Jeff Garzik" at Aug 05, 2002 11:42:28 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a document describing the ethtool ioctl's which need to be
> > implemented in each ethernet driver?
> 
> 
> Unfortunately not.  There is a distinct lack of network driver docs at 
> the moment...  The best documentation is looking at source code of 
> drivers that implement the most ioctls.


I've got a draft of a quick overview doc.  I need to add docs for a few of
the newer commands, still, and I want to get into the structs for each call
in more detail, too.  I want to re-examine a few of recent additions,
before they become too ubiquitous - am I too late to pipe up for my own
aesthetics?

Tim




The ethtool API
08/05/2002

These are the valid parameters to the SIOCETHTOOL ioctl().  Network drivers
should support these as much as possible.

ETHTOOL_GSET
ETHTOOL_SSET

  Get/set NIC settings.  These commands expect a 'struct ethtool_cmd *'
  argument.  This struct includes fields for supported features (speed,
  duplex, transceiver), advertised features, speed, duplex, port,
  transceiver, and autonegotiation.  If the caller attempts to set an
  invalid value for any field, return -EINVAL.

ETHTOOL_GDRVINFO

  Get driver information.  This command expects a 'struct ethtool_drvinfo *'
  argument.  This struct includes the driver identifier as a string, the
  driver version as a string, bus information for the interface, and length
  information for other ETHTOOL_* commands.

ETHTOOL_GREGS

  Get a register dump from the NIC.  This command expects a 'struct
  ethtool_regs regs *' argument.  This struct has a driver-specific version
  field and a length field.  The length field indicates the length of the
  data field to be populated with register information.

ETHTOOL_GWOL
ETHTOOL_SWOL

  Get/set wake-on-lan options for the NIC.  These commands expect a 'struct
  ethtool_wolinfo *' argument.  This struct has fields for supprted and
  active WoL options, and the SecureOn password, if active.  If the caller
  attempts to set an invalid value, return -EINVAL.

ETHTOOL_GMSGLVL
ETHTOOL_SMSGLVL

  Get/set the driver message-level value for the NIC.  This command expects
  a 'struct ethtool_value *' argument.

ETHTOOL_NWAY_RST

  Force auto-negotiation to restart, if it is enabled.  If it is not
  enabled, return -EINVAL.

ETHTOOL_GLINK

  Read the current link status.  This command expects a 'struct
  ethtool_value *' argument.

ETHTOOL_GEEPROM
ETHTOOL_SEEPROM

  Get/set EEPROM data.  These commands expect a 'struct ethtool_eeprom *'
  argument.  This struct has a magic number, an offset and length pair, and a
  data field.  If the offset+length are longer than the maximum size, the
  extra is silently ignored.

ETHTOOL_GCOALESCE
ETHTOOL_SCOALESCE

  Get/set coalescing parameters.  These commands expect a 'struct
  ethtool_coalesce *' argument.  This struct has several fields for
  configuring coalescing - see ethtool.h for details.  If the caller
  attempts to set an invalid value, return -EINVAL.


ETHTOOL_GRINGPARAM
ETHTOOL_SRINGPARAM

  Get/set RX/TX ring parameters.  These commands expect a 'struct
  ethtool_ringparam *' aargument.  This struct has fields for several
  rx pending options, and tx pending. If the caller attempts to set an invalid
  value, return -EINVAL.

ETHTOOL_GPAUSEPARAM
ETHTOOL_SPAUSEPARAM

  Get/set the RX/TX pause parameters.  These commands expect a 'struct
  ethtool_pauseparam *' argument.  This struct has fields to enable
  autonegotiation of pause parameters and to force RX and TX pause control.

ETHTOOL_GRXCSUM
ETHTOOL_SRXCSUM

  Get/set the RX hardware checksum capability/flag.  These commands expect
  a 'struct ethtool_value *' argument.  If the caller attempts to enable RX
  hardware checksumming on an interface that does not support it, return
  -EINVAL.

ETHTOOL_GTXCSUM
ETHTOOL_STXCSUM

  Get/set the TX hardware checksum capability/flag.  These commands expect
  a 'struct ethtool_value *' argument.  If the caller attempts to enable TX
  hardware checksumming on an interface that does not support it, return
  -EINVAL.

ETHTOOL_GSG
ETHTOOL_SSG

  Get/set the scatter/gather capability/flag.  These commands expect a 'struct
  ethtool_value *' argument.  If the caller attempts to set an invalid value,
  return -EINVAL.

ETHTOOL_TEST
/* execute NIC self-test, priv. */

ETHTOOL_GSTRINGS
/* get specified string set */

ETHTOOL_PHYS_ID
/* identify the NIC */

ETHTOOL_GSTATS
/* get NIC-specific statistics */
