Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279788AbRKFRJV>; Tue, 6 Nov 2001 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279832AbRKFRJM>; Tue, 6 Nov 2001 12:09:12 -0500
Received: from dns.itasoftware.com ([63.107.91.98]:63485 "EHLO
	fon.internal.itasoftware.com") by vger.kernel.org with ESMTP
	id <S279788AbRKFRIX>; Tue, 6 Nov 2001 12:08:23 -0500
Message-ID: <3BE81902.95CD4ED7@itasoftware.com>
Date: Tue, 06 Nov 2001 12:08:18 -0500
From: Jim Rees <jimrees@itasoftware.com>
Organization: ITA Software, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: SMP user-mode memory inconsistency after pthread_create
Content-Type: multipart/mixed;
 boundary="------------93157F81266CD66C6A0382C7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------93157F81266CD66C6A0382C7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[1.] SMP user-mode memory inconsistency after pthread_create

[2.]  Starting with nearly any 2.4 Kernel, on SMP platforms (both Intel
and AMD), and SMP-configured Linux kernels, it appears that newly
created threads sometimes get an inconsistent view of memory.  The
enclosed reproducer program is intended to reproduce the problem, but it
can sometimes take more than a couple seconds.  I have seen reproducible
failures on 2.4.2, 2.4.5, 2.4.8, 2.4.9, and 2.4.14.

[3.] SMP, pthreads, memory, coherency, 2.4

[4.] 2.4.2, 2.4.5, 2.4.8, 2.4.9, 2.4.14.

[5.] (oops not applicable)

[6.] See attached .cpp file.

[7.] (env not applicable)

[7.1.] (output of ver_linux)
Linux rho 2.4.14 (root@lih.internal.itasoftware.com) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-85)) #2 Tue Nov 6 10:44:07 EST 2001
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2-3
util-linux             2.10s-12
mount                  2.10r
modutils               2.4.2-5
e2fsprogs              1.19-4
Linux C Library        2.2.2-10
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7-8
Net-tools              1.57-6
Console-tools       19990829-34
Sh-utils               2.0-13
[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1002.336
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1002.336
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

[7.3.]  (no modules loaded)

[7.4.] cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
e800-e83f : Intel Corp. 82557 [Ethernet Pro 100]
  e800-e83f : eepro100
ec00-ec3f : Ensoniq ES1371 [AudioPCI-97]

% cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
  00100000-002060c3 : Kernel code
  002060c4-00254af7 : Kernel data
5fff0000-5fff2fff : ACPI Non-volatile Storage
5fff3000-5fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x]
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : Matrox Graphics, Inc. MGA G400 AGP
da000000-dcffffff : PCI Bus #01
  da000000-da003fff : Matrox Graphics, Inc. MGA G400 AGP
  db000000-db7fffff : Matrox Graphics, Inc. MGA G400 AGP
de000000-de0fffff : Intel Corp. 82557 [Ethernet Pro 100]
de100000-de100fff : Intel Corp. 82557 [Ethernet Pro 100]
  de100000-de100fff : eepro100
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] (lspci -vvv)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: da000000-dcffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
        Subsystem: VIA Technologies, Inc. AC97 Audio Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 3
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de100000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at e800 [size=64]
        Region 2: Memory at de000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
07)
        Subsystem: Ensoniq: Unknown device 8001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0378
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at da000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at db000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

[7.6.] (cat /proc/scsi/scsi -- SCSI not configured)
[7.7.] no other relevant info -- I have reproduced this bug on several
systems, P3, P4, and AMD-MP, various hardware, HIGHMEM 4GIG, or no
HIGHMEM support at all.   The main thing is that this is SMP-only --
hardware must be SMP, and kernel must be configured for SMP.


--------------93157F81266CD66C6A0382C7
Content-Type: text/plain; charset=us-ascii;
 name="threadjam.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="threadjam.cpp"

/*
 * Thread-creation bug reproducer.
 *
 * Author: jimrees@itasoftware.com
 *
 * Starting with nearly any 2.4 kernel, on SMP platforms (both Intel
 * and AMD), it appears that newly created threads sometimes get an
 * inconsistent view of memory.  This program is intended to reproduce
 * the problem, but it can sometimes take a while.  I have seen
 * reproducible failures on 2.4.2, 2.4.5, 2.4.8, 2.4.9, and 2.4.14.
 *
 * main() starts off by creating 'M' leaf-creator threads, each of
 * these rendezvous before starting to fire off children.  Then each
 * leaf-creator fires off 'N' threads, and gives each a pointer to a
 * plain data structure where the fourth element must be the sum of
 * the first three, and the first three are randomly generated. The
 * subthread then 'validates' the structure, complains if the
 * condition fails, and exits.
 *
 * Typical behavior includes segfaults, complaint of failure, and
 * complaint of failure followed immediately by segfault.  I would
 * guess that if a failure can be detected, then there's also a good
 * chance the thread that detected the failure has an inconsistent
 * view of its own stack -- hence the segfaults.  Note that I never
 * seen any other running program affected by this behavior, nor have
 * I seen any kernel panics/oops or system hangs.  The multi-threaded
 * program is the only program affected.
 *
 * With default arguments, the program usually crashes within a few
 * seconds, though some cases take longer -- 4 minutes with no crashes
 * is probably sufficient to say the bug is fixed.
 *
 * Usually, I get the crashes quick if nothing else on the system is
 * consuming significant CPU time.  Though, I have seen crashes happen
 * during kernel builds too.
 *
 * The random sleep variables used are admittedly very crude -- I know
 * that the best sleep precision available is 10ms, so most of the
 * sleeps below are simply until the next kernel tick -- but the
 * reproducer still works fine.
 *
 * To build the reproducer:
 * 
 *   g++ -O threadjam.cpp -lpthread
 */

#include <pthread.h>
#include <stdlib.h>             // atoi
#include <unistd.h>             // usleep,sleep
#include <iostream>             // cout,cerr
#include <fstream>              // ifstream
#include <string.h>             // strcasecmp

/*
 * Parameters:
 * 
 *  N    -- the split, default to 5
 *       -- This is the number of leaf-threads created by each primary thread
 *          per loop pass.
 *  M    -- # leaf-thread creator threads, defaults to 4
 *
 *  SMIN -- min sleep us, defaults to 1000 micro-seconds (1 milli)
 *  SMAX -- max sleep us, defaults to 2000 micro-seconds (2 milli)
 *
 *  Yes, sleeps on Linux are constrained to multiples of 10 milliseconds (plus the
 *  time until the *next* 10ms kernel tick).
 */
static int N = 5;
static int M = 4;
static int SMIN = 1000;
static int SMAX = 2000;

const struct argProc_t {
    const char* argname;
    int* argptr;
} argProc[] = { { "N", &N },
                { "M", &M },
                { "SMIN", &SMIN },
                { "SMAX", &SMAX },
                { NULL, NULL } };

static void parse_args(int argc, char **argv)
{
    while(argc > 1 && argv[0][0] == '-') {
        const argProc_t* a = argProc;
        bool match_found = false;
        while(a->argname) {
            if (strcasecmp(&argv[0][1], a->argname) == 0) {
                *(a->argptr) = atoi(argv[1]);
                cout << a->argname << " = " << *(a->argptr) << endl;
                argv += 2;
                argc -= 2;
                match_found = true;
                break;
            }
            else
                ++a;
        }
        if (!match_found) {
            clog << "No match for " << argv[0] << endl;
            exit(1);
        }
    }
}

/*
 * The Rendezvous class is a way for multiple threads to 'meet up' at
 * a particular point before proceeding.  All threads arriving are
 * blocked until the *final* thread arrives, then all threads are
 * released.  */
class Rendezvous
{
    pthread_mutex_t m_lock;
    pthread_cond_t  m_condition;
    int             m_waiting_for; // # threads waiting for still

public:
    explicit Rendezvous(int mthreads=0) : m_waiting_for(mthreads) {
        pthread_mutex_init(&m_lock, NULL);
        pthread_cond_init(&m_condition, NULL);
    }

    void setThreads(int n) { m_waiting_for = n; }

    // Join the rendezvous...
    void join() {
        pthread_mutex_lock(&m_lock);

        if (--m_waiting_for == 0) {
            // Ah, I was the last one, broadcast, and return...
            pthread_cond_broadcast(&m_condition);
            pthread_mutex_unlock(&m_lock);
            return;
        }

        // Otherwise, wait until notified...
        do {
            pthread_cond_wait(&m_condition, &m_lock);
        }
        while(m_waiting_for > 0);

        pthread_mutex_unlock(&m_lock);
    }
};

////////////////////////////////////////////////////////////////

// A quick 'n dirty counter class with memory locked increment
// support.  Not essential to demonstration of bug.
class AtomicCounter
{
    volatile unsigned int m_count;
public:
    AtomicCounter(unsigned int _initial_value=0) throw() : m_count(_initial_value) {}
    const unsigned int operator++() throw() {
        unsigned int prior_value;
        asm (".byte 0xf0, 0x0f, 0xc1, 0x02" // lock; xaddl %eax, (%edx)
             : "=a" (prior_value)
             : "0" (+1), "m" (m_count), "d" (&m_count)
             : "memory");
        return (prior_value + 1);
    }
    const unsigned int get() const throw() { return m_count; }
};

static AtomicCounter total;
static pthread_mutex_t global_lock = PTHREAD_MUTEX_INITIALIZER;
static ifstream random_input("/dev/urandom");
static int local_random() {
    int n;
    char* ptr = reinterpret_cast<char*>(&n);

    pthread_mutex_lock(&global_lock);
    {
        random_input.read(ptr, sizeof(n));
    }
    pthread_mutex_unlock(&global_lock);

    return n;
}

static double local_random_f() {
    unsigned long r = local_random();
    return double(r) / double(0xffffffff);
}

/*
 * start_up_data is a structure 'passed' to the child
 * thread as part of its creation.  The child is responsible
 * for delete'ing this.
 */
struct start_up_data
{
    int a;
    int b;
    int c;
    int d;

    /*
     * setup() called by parent immediately prior
     * to child thread creation.
     */
    void setup() {
        d = a + b + c;
    }

    /*
     * validate() invoked by child thread upon startup.
     */
    bool validate() const {
        return ((a + b + c) == d);
    }
};

static const char* const failure_message = "Failure detected\n";

void* run(void* data)
{
    start_up_data* v = static_cast<start_up_data*>(data);
    if (!v->validate())
        cerr << failure_message;

    delete v;

    ++total;

    // detach myself
    pthread_detach(pthread_self());
    
    return NULL;
}

static Rendezvous rendezvous;

void* forker(void* data)
{
    const int SLEEP_US = int(double(SMIN) + double(SMAX-SMIN) * local_random_f());

    pthread_mutex_lock(&global_lock);
    cout << SLEEP_US << '\n';
    pthread_mutex_unlock(&global_lock);

    start_up_data* dats[N];

    rendezvous.join();
    
    while(true) {
        // Partially setup each child's structure
        for(int i=0;i<N;++i) {
            dats[i] = new start_up_data;
            dats[i]->a = local_random();
            dats[i]->b = local_random();
            dats[i]->c = local_random();
        }
        pthread_t tid;
        for(int i=0;i<N;++i) {
            // Perform the final setup write here, immeidately
            // prior to thread creation.
            dats[i]->setup();
            pthread_create(&tid, NULL, run, dats[i]);
        }
        usleep(SLEEP_US);
    }
    return NULL;
}

int main(int argc, char **argv)
{
    parse_args(argc-1, argv+1);
    
    // Start M threads, each of which forks 5 threads
    // at a time, and sleeps such that roughly 5-ways
    // splits occur per second.

    pthread_t tid;

    rendezvous.setThreads(M+1);

    for(int i=0;i<M;++i)
        pthread_create(&tid, NULL, forker, NULL);

    // All the forking threads join the rendezvous
    // too, so at the following point, all will start
    // firing.  Basically, this guarantees that all
    // top-level creators are created before any leaf
    // threads are.

    rendezvous.join();

    while(true) {
        /*
         * There's no reason to lock the global mutex
         * here.  cout has its own locking to avoid
         * corruption, and nobody else is accessing
         * cout here.  The atomic counter does not
         * require mutex sync either.
         */
        // pthread_mutex_lock(&global_lock);
        {
            cout << "total = " << total.get() << endl;
        }
        // pthread_mutex_unlock(&global_lock);
        sleep(10);
    }
}

--------------93157F81266CD66C6A0382C7--

