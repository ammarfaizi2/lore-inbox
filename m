Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbTHaOQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbTHaOQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:16:46 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4569 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262463AbTHaOQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:16:10 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Aug_31_14_16_05_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030831141606.15F9E92AAF@merlin.emma.line.org>
Date: Sun, 31 Aug 2003 16:16:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Marcelo, please update!

Patch description:
SECURITY: (information leak)
          fix obfuscation of unknown addresses in terse/oneline modes
  ADD: Implement --mode=fixup to postprocess this script's output,
       replacing addresses by names (useful after updates of this script)
  ADD: --selftest now checks for non-obfuscated addresses
  ADD: Add 9 new addresses.
  FIX: 1 address (wasn't obfuscated)
  REMOVE: 1 address (didn't contain domain part)
  DOC: add empty line before =head1 NAME to fix pod2html output.
  DOC: document --mode options in man page.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |  138 +++++++++++++++++++++++++++++++++++++++----
# 1 files changed, 126 insertions(+), 12 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.81    -> 1.82   
#	            shortlog	1.54    -> 1.55   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/31	matthias.andree@gmx.de	1.82
# SECURITY: (information leak)
# 	  fix obfuscation of unknown addresses in terse/oneline modes
# ADD: Implement --mode=fixup to postprocess this script's output,
#      replacing addresses by names (useful after updates of this script)
# ADD: --selftest now checks for non-obfuscated addresses
# ADD: Add 9 new addresses.
# FIX: 1 address (wasn't obfuscated)
# REMOVE: 1 address (didn't contain domain part)
# DOC: add empty line before =head1 NAME to fix pod2html output.
# DOC: document --mode options in man page.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Aug 31 16:16:05 2003
+++ b/shortlog	Sun Aug 31 16:16:05 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.165 2003/08/29 11:56:43 vita Exp $
+# $Id: lk-changelog.pl,v 0.167 2003/08/31 14:08:56 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -59,6 +59,9 @@
 # customize the following line to change the indentation of the change
 # lines, $indent1 is used for the first line of an entry, $indent for
 # all subsequent lines. $indent is auto-generated from $indent1.
+#
+# WARNING: $indent1 and $indent MUST NOT contain characters that are
+# special in a regular expression!
 my $indent1 = "  o ";
 my $indent  = " " x length($indent1);
 # change this to enable some debugging stuff:
@@ -469,6 +472,7 @@
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
+'gaa:ulticom.com' => 'Gary Algier', # google
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
@@ -551,6 +555,7 @@
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
+'inaky.perez-gonzalez:intel.com' => 'Iñaky Pérez-González', # LK 20030829
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
@@ -786,6 +791,7 @@
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'makisara:abies.metla.fi' => 'Kai Makisara',
+'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
 'manfred:colorfullife.com' => 'Manfred Spraul',
@@ -814,6 +820,7 @@
 'martin:bruli.net' => 'Martin Brulisauer',
 'martin:mdiehl.de' => 'Martin Diehl',
 'martin:meltin.net' => 'Martin Schwenke',
+'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
@@ -878,6 +885,7 @@
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'mporter:cox.net' => 'Matt Porter',
+'mporter:kernel.crashing.org' => 'Matt Porter',
 'mrr:nexthop.com' => 'Mathew Richardson',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -909,10 +917,10 @@
 'nmiell:attbi.com' => 'Nicholas Miell',
 'nobita:t-online.de' => 'Andreas Busch',
 'nstraz:sgi.com' => 'Nathan Straz',
+'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
-'olaf.dietsche' => 'Olaf Dietsche',
 'oleg:tv-sign.ru' => 'Oleg Nesterov',
 'olh:suse.de' => 'Olaf Hering',
 'oliendm:us.ibm.com' => 'Dave Olien',
@@ -998,7 +1006,7 @@
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
-'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdbq
+'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
@@ -1065,6 +1073,7 @@
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
+'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
 'rvinson:mvista.com' => 'Randy Vinson',
@@ -1182,6 +1191,7 @@
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
@@ -1227,6 +1237,7 @@
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
+'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
@@ -1269,6 +1280,7 @@
 'wstinson:wanadoo.fr' => 'William Stinson',
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
+'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
@@ -1286,7 +1298,7 @@
 'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
 'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
-'~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
+'~~~~~~thisentrylast:forconvenience~~~~~' => 'Cesar Brutus Anonymous'
 );
 
 sub doprint(\%@ ); # forward declaration
@@ -1298,6 +1310,7 @@
 # BK_USER,BK_HOST tuple
 sub rmap_address($) {
     my $in = shift;
+    confess "empty string passed to rmap_address" unless $in;
     my $key = lc $in;
     # try hash lookup first, return result if any
     if (defined $addresses{obfuscate $key}) {
@@ -1349,13 +1362,20 @@
 my %table =
   (
    'oneline' => { 'index' => \&get_name,
-		  'print' => \&print_oneline },
+		  'print' => \&print_oneline,
+		  'parse' => \&parse_file },
    'terse'   => { 'index' => \&get_name,
-		  'print' => \&print_terse },
+		  'print' => \&print_terse,
+		  'parse' => \&parse_file },
    'grouped' => { 'index' => \&get_author,
-		  'print' => \&print_grouped },
+		  'print' => \&print_grouped,
+		  'parse' => \&parse_file },
    'full'    => { 'index' => \&get_author,
-		  'print' => \&print_full }
+		  'print' => \&print_full,
+		  'parse' => \&parse_file },
+   'fixup'   => { 'index' => sub { },
+		  'print' => sub { },
+		  'parse' => \&fixup_file }
   );
 
 # temp store
@@ -1584,6 +1604,57 @@
   return join(" ", @a);
 }
 
+sub fixup_file(\%$$ ) {
+# arguments: %log hash
+#            file name
+#            file handle (IO::Handle or IO::File)
+  croak unless wantarray;
+  my $log = shift;
+  my $fn = shift;
+  my $fh = shift;
+  my $nre = '\S+[:@]\S+';
+
+  while($_ = $fh -> getline) {
+    chomp;
+    # grouped/full mode
+    if (/^<($nre)>:$/) {
+      my $a = $1;
+      if ($a =~ /:/) { $a = unveil($a); }
+      my $name = rmap_address($a);
+      if ($name ne $a) { # found name
+	print "$name:\n";
+      } else {
+	print "$_\n";
+      }
+      next;
+    }
+    # oneline/terse mode, unswapped
+    if (/\s+\(($nre)\)$/) {
+      my $a = $1;
+      if ($a =~ /:/) { $a = unveil($a); }
+      my $name = rmap_address($a);
+      if ($name ne $a) { # found name
+	s/\($nre\)$/$name/;
+      }
+      print "$_\n";
+      next;
+    }
+    # oneline/terse mode, swapped
+    if (/^$indent1($nre): /) {
+      my $a = $1;
+      if ($a =~ /:/) { $a = unveil($a); }
+      my $name = rmap_address($a);
+      if ($name ne $a) { # found name
+	s/^$indent1$nre:/$indent1$name:/;
+      }
+      print "$_\n";
+      next;
+    }
+    print "$_\n";
+  }
+  return ();
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -1649,7 +1720,9 @@
 	} else {
 	  $author = $name . ' <' . $address . '>';
 	}
-      } else {
+      } else { # $havename
+	# must obfuscate name since it contains an address still
+	$name = obfuscate $name;
 	$author = '<' . $address . '>';
       }
       $first = 1;
@@ -1712,6 +1785,11 @@
 
 sub selftest() {
     my $rc = 0;
+    foreach my $i (keys %addresses) {
+	if ($i eq unveil $i) {
+	    print STDERR "Warning: address '$i' is not obfuscated!\n";
+	}
+    }
     foreach my $address (unveil keys %addresses) {
 	foreach my $ar (@addrregexps) {
 	    if ($address =~ m/$ar->[0]/) {
@@ -1805,7 +1883,8 @@
 sub doprint(\%@ ) {
   my $log = shift;
   print join("\n", @_), "\n" or write_error();
-  $table{$opt{mode}}->{print}->($log);
+  my $f_print = $table{$opt{mode}}->{'print'};
+  if (defined $f_print) { &$f_print($log); }
 }
 
 # --------------------------------------------------------------------
@@ -1843,7 +1922,7 @@
     my $fh = new IO::File;
     $fh->open($fn, "r")
       or die "cannot open \"$fn\": $!\nAborting";
-    push @prolog, parse_file(%log, $fn, $fh);
+    push @prolog, &{$table{$opt{'mode'}}->{'parse'}}(\%log, $fn, $fh);
     if (not $opt{merge}) {
       doprint(%log, @prolog);
       undef %log;
@@ -1860,7 +1939,7 @@
   my $fh = new IO::Handle;
   $fh->fdopen(fileno(STDIN), "r")
     or die "cannot open stdin: $!\nAborting";
-  @prolog = parse_file(%log, "stdin", $fh);
+  @prolog = &{$table{$opt{'mode'}}->{'parse'}}(\%log, "stdin", $fh);
   doprint(%log, @prolog);
 }
 
@@ -1877,6 +1956,19 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.167  2003/08/31 14:08:56  emma
+# ADD: --selftest now checks for non-obfuscated addresses
+# FIX: 1 address (wasn't obfuscated)
+# REMOVE: 1 address (didn't contain domain part)
+#
+# Revision 0.166  2003/08/31 14:05:04  emma
+# SECURITY: fix obfuscation of unknown addresses in terse/oneline modes
+# ADD: Add 9 new addresses.
+# ADD: Implement --mode=fixup to postprocess this script's output,
+#      replacing addresses by names (useful after updates of this script)
+# DOC: add empty line before =head1 NAME to fix pod2html output.
+# DOC: document --mode options in man page.
+#
 # Revision 0.165  2003/08/29 11:56:43  vita
 # 1 new address
 #
@@ -2438,6 +2530,7 @@
 # Only consider e-mail addresses that are left-justified.
 # Suggested by Greg Kroah-Hartman <greg@kroah.com>.
 #
+
 =head1 NAME
 
 lk-changelog.pl - Reformat BitKeeper ChangeLog for Linux Kernel
@@ -2484,6 +2577,27 @@
 =head1 DESCRIPTION
 
 Summarizes or reformats BitKeeper ChangeLogs for Linux Kernel 2.X.
+
+--mode options are:
+
+=over
+
+=item oneline - a one-line-per-change format (supports --swap)
+
+=item terse - a shortened one-paragraph-per-change format (supports --swap)
+
+=item ordered - shortened changes grouped by sorted author
+
+=item full - full changes grouped by sorted author
+
+=item fixup - a special mode (since 0.166)
+
+This mode replaces addresses by names if the addresses are known. Useful
+to postprocess this script's output after new addresses have been added.
+Besides addresses that are replaced by names, the output is the verbatim
+input. No ordering or grouping takes place.
+
+=back
 
 =head1 ENVIRONMENT
 

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.82
## Wrapped with gzip_uu ##


M'XL( "4#4C\  ^U9;7/;-A+^;/Z*K>5$\L2B2.J=/F?B6&ZJ2?,RBM/TYGSU
M0"0D84P2#$%:EFWUO]['^WC_X'9!4I*5Y.HTO9E^J.PQ2.SBP6*QKW(%WBN>
MN#LA2].98,IDD9]P;E3@!ZE2=V<:7IL^O8ZDQ->&RA1O7/(DXD'C^4O\K><O
M]53*0!G(^):EW@RN>*+<'=MLKF;21<S=G='IB_<_'H\,X^@(3F8LFO)W/(6C
M(R.5R14+?/4LYM$T$Y&9)BQ2(4^9Z<GP;L5[YUB6@S^VT[0Z[?Z=T^^TVW?<
MX>VVU[+9N-OK<L\QML[S+#_'?9BFU7/ZMM/N-^T[Q+/;Q@!LL^> U6Q8O4;3
M!KOCVBVWU7]B.:YEP>=!X8D-=<MX#G_P$4X,#]Z=GKP?#<_^[D)-1!.9H 1"
M1A!P=KF/Y!V B;@&.9YDRLM)<@)9=!G)>03,1RF5X@I$!"E>"&](O"H1<0BE
MSQ4"' \&+@S#.. ACU*HUXEPA)A9C,>!&&T@3J2'*( G5Z"\1,1I58',TCA+
M#Q!"?Q(>!\P3T71CT_$"(A;B0PUM9I(%P"8H!&2QSU*<14$W(/=+8>IUQ0-D
M5"G@(<";<>]2 1X=7Z-Z>5+NKS<J5Q[[/O0AXO,UR43:]\.?7;#+.:C-F8JJ
M*:R1:.O1Z:LW/YW>X_.%3WR>C%*&^O-E2$/,$BWKX,V)2[S PSA=@%;JF*.8
M'(YFG/DVO#Y^=4HZI N*I>_,TC HU&:6 +[TL@W%@XSI#O5]A8PVFW+3> EH
MFRWC[=I?C/I7?@S#8I;Q=&VA,QGR+?-4,YFD@9SFUMFV>U:WU;5[=TV[VV_?
M37B?3;RNU6<6]]G8_X(OW$-!_VK:=LMNM7IWK8[M=+77EQSWG/Z;Y?F2PV_)
M4_B[A2A6NZO]O=W^Q-][O^7O3@?JMO.7R__E\O\OE\_]Y0W4D_DU_=:O,0"4
MQOP[_']@HW4;0_VW GM#WX7@LNYI^T1$,PX.KL R[4X7R%-*?VBY5L]M=_#(
M(8/3ZQCVC&''!LSJB/+A>/1Z^/J%"WLB\O%(J,G(+U_@U?MW9_#ZS=E*G;A9
MPCPR2K0"E@)+J*Y0,?<$"^C\#&UJF@4L 7X=TXV@8KXSANCU*'1URIB;!:E 
MOR+?JL+14ZB^8,D"CH.IX$GU "HPE7(:<&/8;C=IC8C8Y<*,><)OZE,9W;" 
MW[@B2GFPAAC^!WG@[;^)YP7R_ MY--:/+Z$,&L:PV^L18,B"E)N^2Y$@XFF.
M\(HF82#Q9"R\)T;/[N2K%(M8(DPA?.;.XO7FKPH*#)&BEP9C?XP+>Y9>&..%
M8WF6UUBFES U0X\S93(MUZ<IO-5,U0-CV-?W6XW2B7(G 99=+%[SC@3=@ ^C
M3"D9K3<;].TVKAK8EI7;2#Y6$Y.;<QE,)NY8I'-Q@VO-*"BP)*D</A!Y0VS;
M0ONAI;@%#X(+_\)CJ @W1)M0<4*BKXX^RGG@A#CN:<VV>RU"23$K,.7.1224
M-YO)"4_62C_31/BP0=0@\YD4"C$<IT\85R'Z:7;3['7<!9M)2?N;+"FLAR=X
M*(F&S3]F@@>HR9L;L7D>)[>]:ZFX.\>;\A&!JWSUSS@)/[&;CQF_@;=D8QLZ
MM9U>7RLS'ZN_Z@]%/_2-9!$P+*XQ=*!O7/%(\,CCFB%'/N$*G>!YDJ69@F,,
M@HM09JJ*:$V+[(+"+ZZ<4-#:S:.12DF[&#Y0J3[%(,P;\441V78Q/P3$C+YY
MB+(UVXZ6C4;'V,&44J7+R35[_E@_7Q1YXZ"@,\PE)9V>+R8BX+ \T'"M J[U
M93B=C!X$UBG .E\&FR8RB[G_(+A> =>#]I?@,%,%OXF%.J_J+%G%)Z3?0I4B
MW;5F5MD8)Y8'VSMLS6^ :Z@"'.5K]SK0M@WB7U-JYX_V]F ?;C%.LF2J\X9R
MX1%53S,,!3B]\=%8E'X_,XUQWL>A-GSCNC_DSYA>Z>U[)._CX;Q$LLO23M#4
M4Y8D;'&(E' !>[I>P_PC)FDY-8D^F9EMST24&Z%Z_N[)/]QG_\2A>FB<(VT^
MH]/M72"15M6?PI2G9&UT5FW=Z-WQH7[$N)#?=H.N29<Q>EY,H-;XY6\UVF3_
MJ;O7*-?F6S/"M@^+&6*FJ5^AX1)C3L_0^42 A/U#O(3U6E(BDC==2#-M@FD>
MK !P'N$J6*YDF/RT^G?T_<.NYG'/H]URX1)X@#'C=LUQL4DMQHA?I_G<LE! 
MX8H-[4-: P<HNYJS&-6R5L:Y>G)>R_5QOO]GTH=JG&NQ2"K-V-@^\^?T\3 ]
M?**%7\IJ)->$"W\J1:RD(^'<QOJ-3.5WJ66;AV83GF9)!#64;(D.-[ [1<2G
ML;EEC2CCWHQA&M(B5B#,U$:MK"4')3!#@5C5Q@I+O57=K%(1!,9.J9WU4CUS
MB-MV[19&7QV-L%QFWDQK4T#MDB\4/%H5[W13.UJ+ OC'XAJ04<^O#_ON;' Z
M&L'N!Y9$F/7<E235/5$%;# BN5GM?Z<UL[,LE#; 5C)/"C0Z9?"ZR+'1.%(V
M#OCM'E;FMV1CRV7]Z6T1TY>D81+0YQ.T1'^UCN[Z<?E2HWBI30?W:N7Y+!_U
M&3(U@V?88R'3 3R^W=RO2AM6BQUUME@N,0MH3HRX]&>V3RF\UVGFL'J$$@_%
M?SC@KDI]$>V6H C6Q5J%OK$;\2M!U7?1$7RV)= ] ?+^WA:N\I VK?*U;5IE
M6_K.)]*W7:NUDG[=;7]+5UWY'^UHY=L[[B*?_P$==^5;N]C*5W2Q%6/HM%I4
ML)[3$U8X#CUN+<$VT,79(WG%$QI%RL,RTD,=FT)\KM-+'?NXHF.%_'L1J*DL
MIA9)D0%B(MA? >0I@I;KIIF3KQ(06@F;)BR>?16:3'RL[WW$6Z/E:U59G=!-
M***AC6?8N:S/HLN6>CX\?)&V#BU_T2!KI=7R0*P-F\0[H\O5E-PX$/HSMB'(
M"O@&!74.VK1-^OH?)3,>8(>%:=TS;Z#$@?;#M9-PWS2><R7\>V*4S7XIHK\2
M[$"+5: +I=_0"L;H@*$A(C(X>"US[9/98SC1BJ/GE%TBM@8T26MCYEVN__V0
5!Z L/+):]J3+N[;Q7^H9.A3I&   
 

