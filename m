Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTHaOSh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTHaOSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:18:37 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5593 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262255AbTHaORc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:17:32 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.167
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Aug_31_14_17_27_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030831141728.4852592AAF@merlin.emma.line.org>
Date: Sun, 31 Aug 2003 16:17:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.167 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is bk://kernel.bkbits.net/torvalds/tools/

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.167
date: 2003/08/31 14:08:56;  author: emma;  state: Exp;  lines: +16 -4
ADD: --selftest now checks for non-obfuscated addresses
FIX: 1 address (wasn't obfuscated)
REMOVE: 1 address (didn't contain domain part)
----------------------------
revision 0.166
date: 2003/08/31 14:05:04;  author: emma;  state: Exp;  lines: +110 -10
SECURITY: fix obfuscation of unknown addresses in terse/oneline modes
ADD: Add 9 new addresses.
ADD: Implement --mode=fixup to postprocess this script's output,
     replacing addresses by names (useful after updates of this script)
DOC: add empty line before =head1 NAME to fix pod2html output.
DOC: document --mode options in man page.
----------------------------
revision 0.165
date: 2003/08/29 11:56:43;  author: vita;  state: Exp;  lines: +5 -1
1 new address
----------------------------
revision 0.164
date: 2003/08/27 13:34:29;  author: vita;  state: Exp;  lines: +5 -1
1 new address
----------------------------
revision 0.163
date: 2003/08/26 10:09:13;  author: vita;  state: Exp;  lines: +10 -3
4 new addresses; fix Bryan O'Sullivan's regexp
----------------------------
revision 0.162
date: 2003/08/26 00:01:23;  author: emma;  state: Exp;  lines: +5 -2
Fix typo in @addresses_handled_in_regexp, Bryan O'Sullivan's address got hosed.
----------------------------
revision 0.161
date: 2003/08/25 23:56:43;  author: emma;  state: Exp;  lines: +7 -2
Bryan O'Sullivan sent a notice about the other addresses he might be using.
----------------------------
revision 0.160
date: 2003/08/24 10:47:13;  author: emma;  state: Exp;  lines: +5 -1
Merge one mapping from Linus.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.160
retrieving revision 0.167
diff -u -r0.160 -r0.167
--- lk-changelog.pl	24 Aug 2003 10:47:13 -0000	0.160
+++ lk-changelog.pl	31 Aug 2003 14:08:56 -0000	0.167
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.160 2003/08/24 10:47:13 emma Exp $
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
@@ -68,6 +71,7 @@
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
+[ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
@@ -94,6 +98,8 @@
 my @addresses_handled_in_regexp = (
 'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
 'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
+'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
+'bos:serpentine.com' => 'Bryan O\'Sullivan',
 'davem:cheetah.ninka.net' => 'David S. Miller',
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
@@ -178,6 +184,7 @@
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
+'amir.noam:intel.com' => 'Amir Noam',
 'amunoz:vmware.com' => 'Alberto Munoz',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
@@ -255,7 +262,6 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
-'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brihall:pcisys.net' => 'Brian Hall', # google
@@ -324,6 +330,7 @@
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
 'cubic:miee.ru' => 'Ruslan U. Zakirov',
 'cw:f00f.org' => 'Chris Wedgwood',
+'cw:sgi.com' => 'Chris Wedgwood',
 'cweidema:indiana.edu' => 'Christoph Weidemann',
 'cwf:sgi.com' => 'Charles Fumuso',
 'cyeoh:samba.org' => 'Christopher Yeoh',
@@ -465,6 +472,7 @@
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
+'gaa:ulticom.com' => 'Gary Algier', # google
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
@@ -547,6 +555,7 @@
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
+'inaky.perez-gonzalez:intel.com' => 'Iñaky Pérez-González', # LK 20030829
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
@@ -593,6 +602,7 @@
 'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
 'jdavid:farfalle.com' => 'David Ruggiero',
+'jdewand:redhat.com' => 'Julie DeWandel',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
@@ -781,6 +791,7 @@
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'makisara:abies.metla.fi' => 'Kai Makisara',
+'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
 'manfred:colorfullife.com' => 'Manfred Spraul',
@@ -809,6 +820,7 @@
 'martin:bruli.net' => 'Martin Brulisauer',
 'martin:mdiehl.de' => 'Martin Diehl',
 'martin:meltin.net' => 'Martin Schwenke',
+'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
@@ -862,6 +874,7 @@
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
+'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
@@ -872,6 +885,7 @@
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'mporter:cox.net' => 'Matt Porter',
+'mporter:kernel.crashing.org' => 'Matt Porter',
 'mrr:nexthop.com' => 'Mathew Richardson',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -903,10 +917,10 @@
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
@@ -992,7 +1006,7 @@
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
-'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdbq
+'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
@@ -1059,6 +1073,7 @@
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
+'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
 'rvinson:mvista.com' => 'Randy Vinson',
@@ -1103,6 +1118,7 @@
 'shmulik.hen:intel.com' => 'Shmulik Hen',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
+'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
@@ -1140,6 +1156,7 @@
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
+'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
@@ -1174,6 +1191,7 @@
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
@@ -1219,6 +1237,7 @@
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
+'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
@@ -1261,6 +1280,7 @@
 'wstinson:wanadoo.fr' => 'William Stinson',
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
+'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
@@ -1278,7 +1298,7 @@
 'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
 'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
-'~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
+'~~~~~~thisentrylast:forconvenience~~~~~' => 'Cesar Brutus Anonymous'
 );
 
 sub doprint(\%@ ); # forward declaration
@@ -1290,6 +1310,7 @@
 # BK_USER,BK_HOST tuple
 sub rmap_address($) {
     my $in = shift;
+    confess "empty string passed to rmap_address" unless $in;
     my $key = lc $in;
     # try hash lookup first, return result if any
     if (defined $addresses{obfuscate $key}) {
@@ -1341,13 +1362,20 @@
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
@@ -1576,6 +1604,57 @@
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
@@ -1641,7 +1720,9 @@
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
@@ -1704,6 +1785,11 @@
 
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
@@ -1797,7 +1883,8 @@
 sub doprint(\%@ ) {
   my $log = shift;
   print join("\n", @_), "\n" or write_error();
-  $table{$opt{mode}}->{print}->($log);
+  my $f_print = $table{$opt{mode}}->{'print'};
+  if (defined $f_print) { &$f_print($log); }
 }
 
 # --------------------------------------------------------------------
@@ -1835,7 +1922,7 @@
     my $fh = new IO::File;
     $fh->open($fn, "r")
       or die "cannot open \"$fn\": $!\nAborting";
-    push @prolog, parse_file(%log, $fn, $fh);
+    push @prolog, &{$table{$opt{'mode'}}->{'parse'}}(\%log, $fn, $fh);
     if (not $opt{merge}) {
       doprint(%log, @prolog);
       undef %log;
@@ -1852,7 +1939,7 @@
   my $fh = new IO::Handle;
   $fh->fdopen(fileno(STDIN), "r")
     or die "cannot open stdin: $!\nAborting";
-  @prolog = parse_file(%log, "stdin", $fh);
+  @prolog = &{$table{$opt{'mode'}}->{'parse'}}(\%log, "stdin", $fh);
   doprint(%log, @prolog);
 }
 
@@ -1869,6 +1956,34 @@
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
+# Revision 0.165  2003/08/29 11:56:43  vita
+# 1 new address
+#
+# Revision 0.164  2003/08/27 13:34:29  vita
+# 1 new address
+#
+# Revision 0.163  2003/08/26 10:09:13  vita
+# 4 new addresses; fix Bryan O'Sullivan's regexp
+#
+# Revision 0.162  2003/08/26 00:01:23  emma
+# Fix typo in @addresses_handled_in_regexp, Bryan O'Sullivan's address got hosed.
+#
+# Revision 0.161  2003/08/25 23:56:43  emma
+# Bryan O'Sullivan sent a notice about the other addresses he might be using.
+#
 # Revision 0.160  2003/08/24 10:47:13  emma
 # Merge one mapping from Linus.
 #
@@ -2415,6 +2530,7 @@
 # Only consider e-mail addresses that are left-justified.
 # Suggested by Greg Kroah-Hartman <greg@kroah.com>.
 #
+
 =head1 NAME
 
 lk-changelog.pl - Reformat BitKeeper ChangeLog for Linux Kernel
@@ -2461,6 +2577,27 @@
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
 

