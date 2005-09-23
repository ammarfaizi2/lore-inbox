Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVIWOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVIWOqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVIWOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:46:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35007 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751038AbVIWOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:45:59 -0400
Date: Fri, 23 Sep 2005 16:45:44 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: *** Announcement: dmraid 1.0.0.rc9 ***
Message-ID: <20050923144544.GA17702@redhat.com>
Reply-To: mauelshagen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


               *** Announcement: dmraid 1.0.0.rc9 ***

dmraid 1.0.0.rc9 is available at
http://people.redhat.com/heinzm/sw/dmraid/ in source tarball,
source rpm and i386 rpm (with shared and static dietlibc binary).

This release fixes a stripe size bug on VIA and adds RAID10 support
on Promise (see CHANGELOG below for more).


dmraid (Device-Mapper RAID tool) discovers, [de]activates and displays
properties of software RAID sets (i.e. ATARAID) and contained DOS
partitions using the device-mapper runtime of the 2.6 kernel.

The following ATARAID types are supported on Linux 2.6:

Highpoint HPT37X
Highpoint HPT45X
Intel Software RAID
LSI Logic MegaRAID
NVidia NForce
Promise FastTrack
Silicon Image Medley
VIA Software RAID

Please provide insight to support those metadata formats completely.

Thanks.


See files README, which comes with the source tarball for
prerequisites to run this software, further instructions on installing
and using dmraid!


Call for testers:
-----------------

I need testers with the above ATARAID types, to check that the mapping
created by this tool is correct (see options "-t -ay") and access to the
ATARAID data is proper.

In case you have a different ATARAID solution from those listed above,
please feel free to contact me about supporting it in dmraid.

You can activate your ATARAID sets without danger of overwriting
your metadata, because dmraid accesses it read-only unless you use
option -E together with -r in order to erase ATARAID metadata
(see 'man dmraid')!

This is a release candidate version so you want to have backups of your valuable
data *and* you want to test accessing your data read-only first in order to
make sure that the mapping is correct before you go for read-write access.


Contacts:
---------

The author is reachable at <Mauelshagen@RedHat.com>.

For test results, mapping information, discussions, questions, patches,
enhancement requests and the like, please subscribe and mail to
<ataraid-list@redhat.com>.

--

Regards,
Heinz    -- The LVM Guy --


CHANGELOG from dmraid 1.0.0.rc8 to 1.0.0.rc9		2005.09.23
------------------------------------------------------------------

FIXES:
------
o via.c: checksum() calculation;
	 stride size

o toollib.c:  memory leak in _valid_format()

o isw.c: avoid endianess conversion bug in to_cpu();
         disk status check;
	 version check to cover 1.2.02;
	 isw_write() to store metadata in correct sequence

o hpt37x.c, lsi.c, nv.c, pdc.c, sil.c via.c: streamlined grouping switch()

o hpt45x.c: added missing RAID10 to capability string

o sil.c: streamlined quorate()

o misc.c: p_fmt() missed a free_string()


FEATURES:
---------
o pdc.c: support RAID10

o commands.c: added --separator option for selectable string
	      separator character (used with --format etc.)

o display.c: support customizable column output through field
	     identifiers with -c option


MISCELANIOUS:
------------
o metadata.c: use log_alloc_err()

o format.h: introduced caps (RAID capabilities) member

o format.c: introduced get_format_caps() and free_format_caps()
	    to ease library use in installers (pjones@redhat.com)

o display.c: streamlined log_devices()

o toollib.c: stremalined collapse_delimiters()

o isw.c: streamlined isw_read_extended() and setup_rd()

o file.c: cleanup

o add /var/lock/dmraid to rpm

o avoid global variable format_names:
  - change discover_raid_devices() interface
  - saves code in toollib

o added more info to format_error output

o activate.c: display RAID string with unsupported mapping


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
