Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTI2NQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTI2NQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:16:20 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:5899 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263330AbTI2NQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:16:12 -0400
From: Michael Frank <mhf@linuxmail.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=)
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Mon, 29 Sep 2003 21:12:11 +0800
User-Agent: KMail/1.5.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309270344.11262.mhf@linuxmail.org> <yw1xu16wuevx.fsf@users.sourceforge.net>
In-Reply-To: <yw1xu16wuevx.fsf@users.sourceforge.net>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r+Ce/Z/dyVWUiTt"
Message-Id: <200309292112.14492.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_r+Ce/Z/dyVWUiTt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 29 September 2003 17:23, M=E5ns Rullg=E5rd wrote:
> Michael Frank <mhf@linuxmail.org> writes:
>=20
> > Here is my ATA config of 2.6.0-test5. Could you please send same ex
> > your .config. I will build it and see if anything changes.
> >
>=20
> OK, attaching.
>=20
>=20

I patched your ATA config into my config, built it  and tested it=20
with the attached script. More usage info inside script.

$ tstinter start   # creates 2 400MB files

No problems seen, sorry this did not help.

You have no problems with recent 2.4 kernels?

Could you do also lspci -vvxxx using 2.4.22 and see if there is a=20
difference?, also stress it with the script if you can.

Regards
Michael


--Boundary-00=_r+Ce/Z/dyVWUiTt
Content-Type: application/x-shellscript;
  name="tstinter"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tstinter"

#!/bin/bash


#*****************************************************************
#
# tstinter - a linux kernel interactivity test script 
#
# This script invokes:
# - User selectable  number of instances of dd each writing 
#     a large file.  Time taken by dd is displayed in a xterm
#
# - Xterm lists temporary files used by dd every second 
# - Xterm runs vmstat -n every 30ms 
# - Optionl dd read loop of a 200MB file in a xterm
#
# What to look for
#
# Slowdown or stoppping of ls and vmstat xterms
# Mouse hangs
# Poor response on invoking terminal
# Time fluctuations of dd loops - especially of Real time
#
#*****************************************************************
#
# Copyright:   2003 Michael Frank
# License:     GPL Version 2 
#
# Version:    0.2  16 June 2003 
#
# Usage:      ./tstinter FUNCTION [parameters]                                       
# Usage when script is in $PATH: tstinter FUNCTION parameters                
#                                                                 
# FUNCTION:                                                       
#
# start [i] [n]   Start test with [i] invocations of dd writes 
#                  of [n] 4K blocks
#                  when [i] is omitted, 2 instances are invoked
#                    [i] is limited to 10
#                  when [n] is omitted, 100K blocks (400MB) are used
#
# startr [i] [n]  As above, but also invokes one dd read 
#                   loop of a 200MB file
#   
# end            End test
# clean          Cleanup test files $FILE*
#
#*****************************************************************
#
# Examples:
#
# ./tstinter start          Start the test with 2 instances of dd 
#                            each writing 100K 4K blocks
# ./tstinter start 3 20000  Start the test with 3 instances of dd 
#                            each writing 20000 blocks
#
# ./tstinter startr         Start the test with 2 instances of dd 
#                            each writing 100K 4K blocks and with
#                            and with one instance of dd reading a
#                            200MB file
#
# ./tstinter stop            Stop the test
#
# ./tstinter clean [-f/-i]   Cleanup files written by dd 
#              
#*****************************************************************
#
# Requirements: 
#
# recent bash
# recent dd,killall,sleep,usleep,touch,X,xterm,vmstat
# Sufficient free disk space (1G for default invocation)
#  
#*****************************************************************
# Changes
# 0.1 Initial version
# 0.2 
#  - more security advise 
#  - for older dd use 4096 instead of 4K and 100000 instead of 100K
#  - for older bash dont  use ((x--))   
#  - replace uname loop with vmstat loop
#*****************************************************************
#
# Known Bugs and Limitations
#
# [n] can't be specified on its own
#
# tstinter may fill up the disk and slow the system down to the  
# point of unusability 
#
# usage with PIO hardisk mode is not recommended 
#
#
#*****************************************************************
#
# Security:
#
# Save all files and exit all applications in case reset is 
# required
#
# Should not be run as root 
#
# Be sure that $TEMP/$FILE* does not match any valuable files 
#
# Avoid setting n > 2 and if so increase n in small steps
#
#*****************************************************************
#
# Optional configuration: 
#
# Edit TEMP to a user writeable temporary directory if not set
#
if [ "$TEMP" = "" ]; then
  TEMP=/tmp
fi
#
# Edit FILE to another test file prefix as required
#
FILE=_x_y_z_
#
#*****************************************************************
#
# Internal use
#
TEMPFILE=$TEMP/$FILE
#
# For further invocation
#
TSTINTER=$0
#
#*****************************************************************
#
# Execute function
#
case $1 in
#
# start test
#
start | startr)
# start vmstat loop
  $TSTINTER _xtu  
# start ls loop
  $TSTINTER _xtl  
  sleep 5
  if [ "$2" = "" ]; then
    i=2
  else
    i=$2
  fi;
  if ((i > 10)); then
    echo Too many instances $i
    exit 1
  fi
#invoke dd read loop
  if [ "$1" = "startr" ]; then
    $TSTINTER _xread 50K r
   sleep 1
  fi
#invoke dd write loops
  while (( i )); do
    (( i-=1 ))
    $TSTINTER _xwrite "$2" $i
    sleep 1
  done
  ;;
#
# stop test
#
stop) killall ${0#${0%/*}/};; 
#
# Cleanup files
#
#
clean) rm  $2 $TEMPFILE*;;
#
#*****************************************************************
#
# Functions below are for internal use and spawned by the above 
# This method is used for ease of debug and test termination
#
# Loop timed dd read of $2 4K blocks from $TEMPFILE$3
# $TEMPFILE$3 is created first
#
_read) 
  if [ "$2" = "" ]; then
    count=100000
  else
    count=$2
  fi
  dd if=/dev/zero of=$TEMPFILE$3 bs=4096 count=$count
  while (( 1 )); do
    time dd if=$TEMPFILE$3 of=/dev/null bs=4096 count=$count &> /dev/null
  done
  ;;
#
# Read as above in a xterm
#
_xread) xterm -e $TSTINTER _read "$2" $3 &;;
#
# Loop timed dd write of $2 4096 blocks to file $3
#
_write) 
  if [ "$2" = "" ]; then
    count=100000
  else
    count=$2
  fi
  while (( 1 )); do
    time dd if=/dev/zero of=$TEMPFILE$3 bs=4096 count=$count
  done
  ;;
#
# Write as above in a xterm
#
_xwrite) xterm -e $TSTINTER _write "$2" $3 &;;
#
# Start a xterm printing vmstat 
#
_xtu) xterm -e $TSTINTER _xtu1&;;
#             
# Loop vmstat -n with a short delay
#
_xtu1)
  i=0
  while (( 1 )); do
    ((i += 1)); echo -n "$i "
    vmstat -n
    usleep 30000
  done
  ;;
_xtl) xterm -e $TSTINTER _xtl1&;;
#             
# Loop ls -l $TEMPFILE with a delay
#
_xtl1)
  i=0
  while (( 1 )); do
    ((i += 1)); echo "$i "
    ls -l $TEMPFILE*
    sleep 1
  done
  ;;
#
# Default
#
*) echo $TSTINTER bad function $*;;
esac
# End of script

--Boundary-00=_r+Ce/Z/dyVWUiTt--

