Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTFPEMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 00:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTFPEMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 00:12:23 -0400
Received: from fc.capaccess.org ([151.200.199.53]:42506 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S263311AbTFPEMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 00:12:19 -0400
Message-id: <fc.0010c7b200922fb00010c7b200922fb0.922fb6@capaccess.org>
Date: Mon, 16 Jun 2003 00:28:00 -0400
Subject: The HORROR
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, rms@gnu.org,
       dmr@plan9.bell-labs.com
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the post-build listing analagous to "(g)as -a" of the osimplay
(The Atrocity Formerly Known As shasm) build of the file colorgaPC and
it's attendant files. osimplay means "OSen as easy as childsplay". This is
a floppy boot "sector" and initial Pirouette to Pmode. This is the very
first such successful pirouette in osimplay. Works on a P1 and a P2. 80
bytes? There was a bug in "= C to CR0" that held me up for a while. I
still have to compare things to e.g.

echo "mov %cr0, %ecx" | as -a
                                once in a while. The 0x7c00 of zero-spam
gets clipped off by an external program (written in osimplay of course)
before cp'ing it to /dev/fd0. The stuff to the right is basically osimplay
source, but some labels have been reduced to numbers. I've tidied up the
columns a bit, but changed nothing but whitespace. EIP never gets to
0x7c23. The 3-digit numbers in the middle actual-code/data column are
octal. Unprefixed numbers on the right are decimal. osimplay is of course
a trivial port to pdksh.

00000000  00...                         ALLOT 0x7C00
00007c00  270 50 02{ # Boolean bitwise O= 592 to A              -x86   =
00007c03  271 01 00                     = 1 to C
00007c06  31 322                        XOR D with D
00007c08  273 00 7c                     = 0x7c00 to B
00007c0b  cd 13                         submit 0x13
00007c0d  fa                            nosurprises
00007c0e  0f 01 16 31 7c                setGDT 31793
00007c13  271 01 00                     = 1 to C
00007c16  0f 20 301                     = C to CR0
00007c19  ea 1e 7c 08 00                 hand assembled jmp GDT1:cs32
00007c1e                (O) cs32
pmode

00007c1e  e9 fb ff ff ff                jump cs32
00007c23  270 10 00 00 00               = 0x10 to A
00007c28  8e 330                        = A to DS
00007c2a  8e 320                        = A to SS
00007c2c  274 00 90 00 00               = 0x9000 to SP
00007c31                (O) initial_gdtr
00007c31  00 04 37 7c 00 00
00007c37                (O) GDT_templates
00007c37  00 00 00 00 00 00 00 00
00007c3f  ff ff 00 00 00 9a cf 00       index 1
00007c47  ff ff 00 00 00 92 cf 00       index 2 *4k BIG f-nybble
00007c4f  f4                    halt



This is a glossary of my current osimplay courtesy of grep "()"
../tool/osimplay. Internals and rarely used instructions are left out as
"( )" rather than "()". Note that as a shell script there is no reason to
not project-specificize the particular osimplay in use. Per source file,
even. Transiently, per file, even. This is the target sysdev version of
osimplay, with Linux syscalls and ELF twiddlers elided. Heheh. He said
"elided". Like, Dude, you've been elided. HAHAHAHAaaHAaHAHAHAaaHhhaa.

# ASSEMBLER DIRECTIVES/HELPERS                                   ()
ab              () { # assemble bytes.  pass-sensitive.         =shasm
ao              () { # assemble one octal string as a byte      =shasm
ad              () { # assemble duals.   pass-sensitive.        =shasm
aq              () { # assemble quads. pass-sensitive quads     =shasm
ac              () { # assemble cells. pass-cell-sensitive.     =shasm
align           () { # like e.g. .align                         =shasm
allot           () { # relative .org, like Forth ALLOT          =shasm
asciibyte       () { # e.g.      ab  `asciibyte c q d`          =shasm
bases           () { # print # in decimal, binary, octal, hex   =shasm
binary          () { # binary <strings of ones and zeros>       =shasm
chom            () { # chom chomp  returns  chom                =shasm
homp            () { # homp chomp  is  homp                     =shasm
fillabsolute    () { # like .org, but fill to just BEFORE arg   =shasm
L               () { # label, set a branch bla at $H            =shasm

# x86 general instructions                                      ()
=               () { # Clobber. many variants, most freq. insn  -x86 MOV
1+              () { # increment                                -x86 INC
1-              () { # minus one, decrement                     -x86 DEC
/               () { # divide. 38 clocks.                       -x86 DIV
+               () { # add                                      -x86 ADD
+A              () { # add immediate to A, 32 bit only          -x86 ADD
+byte           () { # add immediate byte                       -x86 ADD
+carry          () { # add with carry.                          -x86 ADC
-               () { # subtract.                                -x86 SUB
-test           () { # do a subtract but save only the flags    -x86 CMP
-borrow         () { # dest - source - carry --> dest           -x86 SBB
AND             () { # Boolean bitwise AND                      -x86   =
ANDtest         () { # AND with no result but flags             -x86 TEST
NOT             () { # invert the bits                          -x86   =
OR              () { # Boolean bitwise OR                       -x86   =
XOR             () { # Boolean bitwise exclusive OR             -x86   =
biton           () { # set a particular bit to 1                -x86 BTS
bitoff          () { # set a particular bit to 0                -x86 BTR
call            () { # jump to subroutine, push return address  -x86 CALL
downroll        () { # down-significance bit-rotate             -x86 ROR
downshift       () { # down-significance bitshift, 0-fill high. -x86 SHR
extend          () { # sign-extend A to D:A                     -x86 CWD
fetches         () { # @ SI to A, scaled in/decr. SI, decr. C   -x86 LODSx
flags           () { #  copy  FLAGS into AX                     -x86 LAHF
jump            () { # unconditional branch                     -x86 JMP
address         () { # x86 artifact quick address-math thingy   -x86 LEA
lookup          () { # byte lookup for e.g. ASCII->EBCDIC       -x86 XLATB
ls1bit          () { # bit number of least significant 1-bit    -x86 BSF
ms1bit          () { # bit number of most significant 1-bit     -x86 BSR
multiply        () { # arg * A --> D:A                          -x86 MUL
negate          () { # 2's-complement; Boolean NOT, then incr.  -x86 NEG
nop             () { # burn 3 clocks with no state effect       -x86 NOP
return          () { # return from a near call                  -x86 RET
setflags        () { # copy AH to the FLAGS register-half       -x86 SAHF
signedmultiply  () { # partial                                  -x86 IMUL
signeddivide    () { #                                          -x86 IDIV
swap            () { # swap two values.                         -x86 XCHG
uprollcarry     () { # up-significance bit roll through carry   -x86 RCL
uproll          () { #                                          -x86 ROL
upshift         () { #                                          -x86 SAL
when            () { # IF. conditional branch. Many variants.   -x86 jxx
widedownshift   () { # partial                                  -x86 SHRD
wideupshift     () { # partial                                  -x86 SHLD
within          () { # check value against 2 bounding values    -x86 BOUND

# OSIMPA COMPEMBLER                                     ]]]]]   ()
osimplay        () { # main(). e.g. osimplay <your source file>
beam            () { # Fill a range of an xray with a jump address
cell            () { # name/allot a cell-size storage location
copies          () { # plural, range-to-range copy, handles overlaps
clump           () { # the cereal from the C struct() complete breakfast
entrance        () { # name/begin a reentrant procedure
leave           () { # return from the current reentrant procedure
fill            () { # plural, copies A across range @ DI       -x86 STOSD
flag            () { # assert the zero/sign flags of a register's value
enter           () { # how you invoke an osimplay reentrant procedure
maskbyte        () { # mask arg down to a byte
maskdual        () { # mask arg down to it's lowest-significance 16 bits
match           () { # plural, range-range compare, zero flag=match
max             () { # max arg1 arg2 label    leaves greater in arg2
min             () { # min arg1 arg2 label    leaves lesser in arg2
numbering       () { # C enum, but not strictly constants and no commas
quad            () { # name/allot a 4-byte storage location
quadtohex       () { # quad value to ASCII hexadecimal string
range           () { # name/allot some count-cell prefixed memory
ring            () { # ring-wise increment a strand's index
ringstore       () { # ringstore ring reg/lit [arg3 means cell]  !A
scale           () { # Forth */ with a shift instead of a divide
scan            () { # plural, compare A to memory range @ DI until
hit/miss
strand          () { # name/allot a general array and 8 cells of metadata
sum             () { # plural, additive checksum
tag             () { # tag <string>    ASCII bytes and zeros in a cell
text            () { # name/allot some text
xjump           () { # indexed jump into an xray execution array
xray            () { # name an execution array for beam, yarx and xjump
xsum            () { # plural, XOR-ing checksum
yarx            () { # finish compembling an xray and it's beams
zero            () { # simple convenience to set (a) register(s) to 0


Rick Hohensee
Precision Mojo Engineer

