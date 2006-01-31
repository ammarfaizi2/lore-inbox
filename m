Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWAaNvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWAaNvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWAaNvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:51:39 -0500
Received: from ns2.suse.de ([195.135.220.15]:30881 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750854AbWAaNvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:51:38 -0500
Date: Tue, 31 Jan 2006 14:51:25 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Rescan SCSI Bus without /proc/scsi?
Message-ID: <20060131135125.GB9188@tpkurt.wlan.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andreas Schwab <schwab@suse.de>,
	Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051031110344.GA16691@schottelius.org> <je4q6y547h.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <je4q6y547h.fsf@sykes.suse.de>
X-Operating-System: Linux 2.6.16-rc1-git3-5-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2005 at 12:13:54PM +0100, Andreas Schwab wrote:
> Nico Schottelius <nico-kernel@schottelius.org> writes:
>=20
> > This breaks the popular rescan-scsi-bus.sh from Kurt Garloff.
> > Is there a possibility to do that through /sys somehow or do I have
> > to reanable /proc/scsi?
>=20
> Your version of rescan-scsi-bus.sh is quite old.  Current versions of
> rescan-scsi-bus.sh already use /sys when available.

Attached for reference.
--=20
Kurt Garloff

--uQr8t48UFsdbeI+V
Content-Type: application/x-sh
Content-Disposition: attachment; filename="rescan-scsi-bus.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A# Skript to rescan SCSI bus, using the =0A# scsi add-single-d=
evice mechanism=0A# (w) 1998-03-19 Kurt Garloff <kurt@garloff.de> (c) GNU G=
PL=0A# (w) 2003-07-16 Kurt Garloff <garloff@suse.de> (c) GNU GPL=0A# $Id: r=
escan-scsi-bus.sh,v 1.19 2005/10/08 23:59:46 garloff Exp $=0A=0Asetcolor ()=
=0A{=0A  red=3D"\e[0;31m"=0A  green=3D"\e[0;32m"=0A  yellow=3D"\e[0;33m"=0A=
  bold=3D"\e[0;1m"=0A  norm=3D"\e[0;0m"=0A}=0A=0Aunsetcolor () =0A{=0A  red=
=3D""; green=3D""=0A  yellow=3D""; norm=3D""=0A}=0A=0A# Return hosts. sysfs=
 must be mounted=0Afindhosts_26 ()=0A{=0A  hosts=3D=0A  if ! ls /sys/class/=
scsi_host/host* >/dev/null 2>&1; then=0A    echo "No SCSI host adapters fou=
nd in sysfs"=0A    exit 1;=0A    #hosts=3D" 0"=0A    #return=0A  fi =0A  fo=
r hostdir in /sys/class/scsi_host/host*; do=0A    hostno=3D${hostdir#/sys/c=
lass/scsi_host/host}=0A    hostname=3D`cat $hostdir/proc_name`=0A    hosts=
=3D"$hosts $hostno"=0A    echo "Host adapter $hostno ($hostname) found."=0A=
  done  =0A}=0A=0A# Return hosts. /proc/scsi/HOSTADAPTER/? must exist=0Afin=
dhosts ()=0A{=0A  hosts=3D=0A  for driverdir in /proc/scsi/*; do=0A    driv=
er=3D${driverdir#/proc/scsi/}=0A    if test $driver =3D scsi -o $driver =3D=
 sg -o $driver =3D dummy -o $driver =3D device_info; then continue; fi=0A  =
  for hostdir in $driverdir/*; do=0A      name=3D${hostdir#/proc/scsi/*/}=
=0A      if test $name =3D add_map -o $name =3D map -o $name =3D mod_parm; =
then continue; fi=0A      num=3D$name=0A      driverinfo=3D$driver=0A      =
if test -r $hostdir/status; then=0A	num=3D$(printf '%d\n' `sed -n 's/SCSI h=
ost number://p' $hostdir/status`)=0A	driverinfo=3D"$driver:$name"=0A      f=
i=0A      hosts=3D"$hosts $num"=0A      echo "Host adapter $num ($driverinf=
o) found."=0A    done=0A  done=0A}=0A=0A# Get /proc/scsi/scsi info for devi=
ce $host:$channel:$id:$lun=0A# Optional parameter: Number of lines after fi=
rst (default =3D 2), =0A# result in SCSISTR, return code 1 means empty.=0Ap=
rocscsiscsi ()=0A{  =0A  if test -z "$1"; then LN=3D2; else LN=3D$1; fi=0A =
 CHANNEL=3D`printf "%02i" $channel`=0A  ID=3D`printf "%02i" $id`=0A  LUN=3D=
`printf "%02i" $lun`=0A  grepstr=3D"scsi$host Channel: $CHANNEL Id: $ID Lun=
: $LUN"=0A  SCSISTR=3D`cat /proc/scsi/scsi | grep -A$LN -e"$grepstr"`=0A  i=
f test -z "$SCSISTR"; then return 1; else return 0; fi=0A}=0A=0A# Find sg d=
evice with 2.6 sysfs support=0Asgdevice26 ()=0A{=0A  SGDEV=3D`readlink /sys=
/class/scsi_device/$host\:$channel\:$id\:$lun/device/generic`=0A  SGDEV=3D`=
basename $SGDEV`=0A}=0A=0A# Find sg device with 2.4 report-devs extensions=
=0Asgdevice24 ()=0A{=0A  if procscsiscsi 3; then=0A    SGDEV=3D`echo "$SCSI=
STR" | grep 'Attached drivers:' | sed 's/^ *Attached drivers: \(sg[0-9]*\).=
*/\1/'`=0A  fi=0A}=0A=0A# Find sg device that belongs to SCSI device $host =
$channel $id $lun=0Asgdevice ()=0A{=0A  SGDEV=3D=0A  if test -d /sys/class/=
scsi_device; then=0A    sgdevice26=0A  else  =0A    DRV=3D`grep 'Attached d=
rivers:' /proc/scsi/scsi 2>/dev/null`=0A    repdevstat=3D$((1-$?))=0A    if=
 [ $repdevstat =3D 0 ]; then=0A      echo "scsi report-devs 1" >/proc/scsi/=
scsi=0A      DRV=3D`grep 'Attached drivers:' /proc/scsi/scsi 2>/dev/null`=
=0A      if [ $? =3D 1 ]; then return; fi=0A    fi=0A    if ! `echo $DRV | =
grep 'drivers: sg' >/dev/null`; then=0A      modprobe sg=0A    fi=0A    sgd=
evice24=0A    if [ $repdevstat =3D 0 ]; then=0A      echo "scsi report-devs=
 0" >/proc/scsi/scsi=0A    fi=0A  fi=0A}       =0A=0A# Test if SCSI device =
is still responding to commands=0Atestonline ()=0A{=0A  if test ! -x /usr/b=
in/sg_turs; then return 0; fi=0A  sgdevice=0A  if test -z "$SGDEV"; then re=
turn 0; fi=0A  sg_turs /dev/$SGDEV >/dev/null 2>&1=0A  RC=3D$?=0A  #echo -e=
 "\e[A\e[A\e[A${yellow}Test existence of $SGDEV =3D $RC ${norm} \n\n\n"=0A =
 if test $RC =3D 1; then return $RC; fi=0A  # OK, device online, compare IN=
QUIRY string=0A  INQ=3D`sg_inq -36 /dev/$SGDEV`=0A  IVEND=3D`echo "$INQ" | =
grep 'Vendor identification:' | sed 's/^[^:]*: \(.*\)$/\1/'`=0A  IPROD=3D`e=
cho "$INQ" | grep 'Product identification:' | sed 's/^[^:]*: \(.*\)$/\1/'`=
=0A  IPREV=3D`echo "$INQ" | grep 'Product revision level:' | sed 's/^[^:]*:=
 \(.*\)$/\1/'`=0A  STR=3D`printf "  Vendor: %-08s Model: %-16s Rev: %-4s" "=
$IVEND" "$IPROD" "$IPREV"`=0A  procscsiscsi=0A  SCSISTR=3D`echo "$SCSISTR" =
| grep 'Vendor:'`=0A  if [ "$SCSISTR" !=3D "$STR" ]; then=0A    echo -e "\e=
[A\e[A\e[A\e[A${red}$SGDEV changed: ${bold}\nfrom:${SCSISTR#* } \nto: $STR =
${norm}\n\n\n"=0A    return 1=0A  fi=0A  return $RC=0A}=0A=0A# Test if SCSI=
 device $host $channen $id $lun exists=0A# Outputs description from /proc/s=
csi/scsi, returns SCSISTR =0Atestexist ()=0A{=0A  SCSISTR=3D=0A  if procscs=
iscsi; then=0A    echo "$SCSISTR" | head -n1=0A    echo "$SCSISTR" | tail -=
n2 | pr -o4 -l1=0A  fi=0A}=0A=0A# Perform search (scan $host)=0Adosearch ()=
=0A{=0A  for channel in $channelsearch; do=0A    for id in $idsearch; do=0A=
      for lun in $lunsearch; do=0A        SCSISTR=3D=0A	devnr=3D"$host $cha=
nnel $id $lun"=0A	echo "Scanning for device $devnr ..."=0A	printf "${yellow=
}OLD: $norm"=0A	testexist=0A	if test ! -z "$remove" -a ! -z "$SCSISTR"; the=
n=0A	  # Device exists: Test whether it's still online=0A	  testonline=0A	 =
 if test $? =3D 1 -o ! -z "$forceremove"; then=0A	    echo -en "\r\e[A\e[A\=
e[A${red}REM: "=0A	    echo "$SCSISTR" | head -n1=0A	    echo -e "${norm}\e=
[B\e[B"=0A	    echo "scsi remove-single-device $devnr" >/proc/scsi/scsi=0A	=
    echo "scsi add-single-device $devnr" >/proc/scsi/scsi=0A          fi  =
=0A	  printf "\r\x1b[A\x1b[A\x1b[A${yellow}OLD: $norm"=0A	  testexist=0A	  =
if test -z "$SCSISTR"; then =0A	    printf "\r${red}DEL: $norm\r\n\n\n\n" =
=0A	    let rmvd+=3D1; =0A          fi=0A	fi=0A	if test -z "$SCSISTR"; then=
=0A	  # Device does not exist, try to add=0A	  printf "\r${green}NEW: $norm=
"=0A	  echo "scsi add-single-device $devnr" >/proc/scsi/scsi=0A	  testexist=
=0A	  if test -z "$SCSISTR"; then=0A	    # Device not present=0A	    printf=
 "\r\x1b[A";=0A  	    # Optimization: if lun=3D=3D0, stop here (only if in =
non-remove mode)=0A	    if test $lun =3D 0 -a -z "$remove" -a $optscan =3D =
1; then =0A	      break;=0A	    fi  =0A	  else =0A	    let found+=3D1; =0A	=
  fi=0A	fi=0A      done=0A    done=0A  done=0A}=0A =0A# main=0Aif test @$1 =
=3D @--help -o @$1 =3D @-h -o @$1 =3D @-?; then=0A    echo "Usage: rescan-s=
csi-bus.sh [options] [host [host ...]]"=0A    echo "Options:"=0A    echo " =
-l activates scanning for LUNs 0-7    [default: 0]"=0A    echo " -w scan fo=
r target device IDs 0 .. 15 [default: 0-7]"=0A    echo " -c enables scannin=
g of channels 0 1   [default: 0]"=0A    echo " -r enables removing of devic=
es        [default: disabled]"=0A    echo "--remove:        same as -r"=0A =
   echo "--forceremove:   Remove and readd every device (dangerous)"=0A    =
echo "--nooptscan:     don't stop looking for LUNs is 0 is not found"=0A   =
 echo "--color:         use coloured prefixes OLD/NEW/DEL"=0A    echo "--ho=
sts=3DLIST:    Scan only host(s) in LIST"=0A    echo "--channels=3DLIST: Sc=
an only channel(s) in LIST"=0A    echo "--ids=3DLIST:      Scan only target=
 ID(s) in LIST"=0A    echo "--luns=3DLIST:     Scan only lun(s) in LIST"  =
=0A    echo " Host numbers may thus be specified either directly on cmd lin=
e (deprecated) or"=0A    echo " or with the --hosts=3DLIST parameter (recom=
mended)."=0A    echo "LIST: A[-B][,C[-D]]... is a comma separated list of s=
ingle values and ranges"=0A    echo " (No spaces allowed.)"=0A    exit 0=0A=
fi=0A=0Aexpandlist ()=0A{=0A    list=3D$1=0A    result=3D""=0A    first=3D$=
{list%%,*}=0A    rest=3D${list#*,}=0A    while test ! -z "$first"; do =0A	b=
eg=3D${first%%-*};=0A	if test "$beg" =3D "$first"; then=0A	    result=3D"$r=
esult $beg";=0A    	else=0A    	    end=3D${first#*-}=0A	    result=3D"$res=
ult `seq $beg $end`"=0A	fi=0A	test "$rest" =3D "$first" && rest=3D""=0A	fir=
st=3D${rest%%,*}=0A	rest=3D${rest#*,}=0A    done=0A    echo $result=0A}=0A=
=0Aif test ! -d /proc/scsi/; then=0A  echo "Error: SCSI subsystem not activ=
e"=0A  exit 1=0Afi	=0A=0A# defaults=0Aunsetcolor=0Alunsearch=3D"0"=0Aidsear=
ch=3D`seq 0 7`=0Achannelsearch=3D"0"=0Aremove=3D=0Aforceremove=3D=0Aoptscan=
=3D1=0Aif test -d /sys/class/scsi_host; then =0A  findhosts_26=0Aelse  =0A =
 findhosts=0Afi  =0A=0A# Scan options=0Aopt=3D"$1"=0Awhile test ! -z "$opt"=
 -a -z "${opt##-*}"; do=0A  opt=3D${opt#-}=0A  case "$opt" in=0A    l) luns=
earch=3D`seq 0 7` ;;=0A    w) idsearch=3D`seq 0 15` ;;=0A    c) channelsear=
ch=3D"0 1" ;;=0A    r) remove=3D1 ;;=0A    -remove)      remove=3D1 ;;=0A  =
  -forceremove) remove=3D1; forceremove=3D1 ;;=0A    -hosts=3D*)     arg=3D=
${opt#-hosts=3D};   hosts=3D`expandlist $arg` ;;=0A    -channels=3D*)  arg=
=3D${opt#-channels=3D};channelsearch=3D`expandlist $arg` ;; =0A    -ids=3D*=
)   arg=3D${opt#-ids=3D};         idsearch=3D`expandlist $arg` ;; =0A    -l=
uns=3D*)  arg=3D${opt#-luns=3D};        lunsearch=3D`expandlist $arg` ;; =
=0A    -color) setcolor ;;=0A    -nooptscan) optscan=3D0 ;;=0A    *) echo "=
Unknown option -$opt !" ;;=0A  esac=0A  shift=0A  opt=3D"$1"=0Adone    =0A=
=0A# Hosts given ?=0Aif test "@$1" !=3D "@"; then =0A  hosts=3D$*; =0Afi=0A=
=0Aecho "Scanning hosts $hosts channels $channelsearch for "=0Aecho " SCSI =
target IDs " $idsearch ", LUNs " $lunsearch=0Atest -z "$remove" || echo " a=
nd remove devices that have disappeared"=0Adeclare -i found=3D0=0Adeclare -=
i rmvd=3D0=0Afor host in $hosts; do =0A  dosearch; =0Adone=0Aecho "$found n=
ew device(s) found.               "=0Aecho "$rmvd device(s) removed.       =
          "=0A=0A
--uQr8t48UFsdbeI+V--

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD32tdxmLh6hyYd04RAhhdAKC2qGcDkophUEqHOYcOIj70AkJriQCeMYBd
iqcBe7pTJDcDBlwAcTGyzaU=
=nPi7
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
