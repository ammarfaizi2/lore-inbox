Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVCATLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVCATLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVCATLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:11:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261658AbVCATLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:11:32 -0500
Date: Tue, 1 Mar 2005 20:11:27 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: *** Announcement: dmraid 1.0.0.rc6 ***
Message-ID: <20050301191127.GA13494@redhat.com>
Reply-To: mauelshagen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


               *** Announcement: dmraid 1.0.0.rc6 ***

dmraid 1.0.0.rc6 is available at
http://people.redhat.com:/heinzm/sw/dmraid/ in source tarball,
source rpm and i386 rpms (shared, static and dietlibc).

This release introduces support for VIA Software RAID.

dmraid (Device-Mapper Raid tool) discovers, [de]activates and displays
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
VIA Software RAID	*** NEW ***

Please provide insight to support those metadata formats completely.

Thanks.


See files README and CHANGELOG, which come with the source tarball for
prerequisites to run this software, further instructions on installing
and using dmraid!

CHANGELOG is contained below for your convenience as well.


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


CHANGELOG:
---------

Changelog from dmraid 1.0.0-rc5f to 1.0.0.rc6		2005.02.28

FIXES:
------
o sil status()
o _sil_read() used LOG_NOTICE rather than LOG_INFO in order to
  avoid messages about valid metadata areas being displayed
  during "dmraid -vay".
o isw, sil filed metadata offset on "-r -D" in sectors rather than in bytes.
o isw needed dev_sort() to sort RAID devices in sets correctly.
o pdc metadata format handler name creation. Lead to
  wrong RAID set grouping logic in some configurations. 
o dos.c: partition table code fixes by Paul Moore
o _free_dev_pointers(): fixed potential OOB error
o hpt37x_check: deal with raid_disks = 1 in mirror sets
o pdc_check: status & 0x80 doesn't always show a failed device;
  removed that check for now. Status definitions needed.
o sil addition of RAID sets to global list of sets
o sil spare device memory leak
o group_set(): removal of RAID set in case of error
o hpt37x: handle total_secs > device size
o allow -p with -f
o enhanced error message by checking target type against list of
  registered target types


FEATURES:
---------
o VIA metadata format handler
o added RAID10 to lsi metadata format handler
o "dmraid -rD": file device size into {devicename}_{formatname}.size
o "dmraid -tay": pretty print multi-line tables ala "dmsetup table"
o "dmraid -l": display supported RAID levels + manual update


MISCELANIOUS:
------------

o more inline comments
o libdmraid_init() now returns lib context
o check_set() enhanced to do RAID set stack unrolling and
  to check correct number of devices in sets; saves code in
  metadata format handlers
o introduced read_raid_dev() to further reduce metadata format handler code
o optimized parse_table()
o updated dmraid manual
o devmapper.c: check target type registered before trying to load table record
o misc.c: avoid find_percent().

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
