Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293402AbSCKAIy>; Sun, 10 Mar 2002 19:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293400AbSCKAIq>; Sun, 10 Mar 2002 19:08:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293397AbSCKAIa>;
	Sun, 10 Mar 2002 19:08:30 -0500
Message-ID: <3C8BF593.A5F5BE19@mandrakesoft.com>
Date: Sun, 10 Mar 2002 19:08:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Robert Love <rml@tech9.net>, Andreas Jaeger <aj@suse.de>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
In-Reply-To: <197603031558.G23FwZY05020@www.hockin.org>
Content-Type: multipart/mixed;
 boundary="------------A043F6850FA9706A1CC3A389"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A043F6850FA9706A1CC3A389
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tim Hockin wrote:
> If we are going to pick an affinity system, please, let's consider sysmp().

Not too bad.  I picked a random sysmp(2) man page off the net (attached
for ease of other's reference).

It duplicates some stuff set elsewhere, and seems more than a bit like
ioctl(2) by another name, but doesn't seem too bad.  Note we should be
careful not to overengineer the interface, either...

Just setting a bitmask does seem a bit limiting when thinking about the
future, agreed.

-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
--------------A043F6850FA9706A1CC3A389
Content-Type: text/plain; charset=us-ascii;
 name="sysmp.man.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysmp.man.txt"


     sysmp - multiprocessing control

C SYNOPSIS


     #include <sys/types.h>
     #include <sys/sysmp.h>
     #include <sys/sysinfo.h> /* for SAGET and MINFO structures */
     int sysmp (int cmd, ...);
     ptrdiff_t sysmp (int cmd, ...);"

DESCRIPTION


     sysmp provides control/information for miscellaneous system services.
     This system call is usually used by system programs and is not intended
     for general use.  The arguments arg1, arg2, arg3, arg4 are provided for
     command-dependent use.

     As specified by cmd, the following commands are available:

     MP_CLEARCFSSTAT
     MP_CLEARNFSSTAT
     MP_NUMA_GETCPUNODEMAP
     MP_NUMA_GETDISTMATRIX
                    These are all interfaces that are used to implement
                    various system library functions.  They are all subject to
                    change and should not be called directly by applications.

     MP_PGSIZE      The page size of the system is returned (see
                    getpagesize(2)).

     MP_SCHED       Interface for the schedctl(2) system call.

     MP_NPROCS      Returns the number of processors physically configured.

     MP_NAPROCS     Returns the number of processors that are available to
                    schedule unrestricted processes.

     MP_STAT        The processor ids and status flag bits of the physically
                    configured processors are copied into an array of pda_stat
                    structures to which arg1 points.  The array must be large
                    enough to hold as many pda_stat structures as the number
                    of processors returned by the MP_NPROCS sysmp command.
                    The pda_stat structure and the various status bits are
                    defined in <sys/pda.h>.

     MP_EMPOWER     The processor number given by arg1, interpreted as an
                    'int', is empowered to run any unrestricted processes.
                    This is the default for all processors.  This command
                    requires superuser authority.

     MP_RESTRICT    The processor number given by arg1, interpreted as an
                    'int', is restricted from running any processes except
                    those assigned to it by a MP_MUSTRUN or MP_MUSTRUN_PID
                    command, a runon(1) command or because of hardware
                    necessity.  Note that processor 0 cannot be restricted.
                    This command requires superuser authority.  On Challenge
                    Series machines, all timers belonging to the processor are
                    moved to the processor that owns the clock as reported by
                    MP_CLOCK.

     MP_ISOLATE     The processor number given by arg1, interpreted as an
                    'int', is isolated from running any processes except those
                    assigned to it by a MP_MUSTRUN command, a runon(1) command
                    or because of hardware necessity.  Instruction cache and
                    Translation Lookaside Buffer synchronization across
                    processors in the system is minimized or delayed on an
                    isolated processor until system services are requested.
                    Note that processor 0 cannot be isolated.  This command
                    requires superuser authority.  On Challenge Series
                    machines, all timers belonging to the processor are moved
                    to the processor that owns the clock as reported by
                    MP_CLOCK.

     MP_UNISOLATE   The processor number given by arg1, interpreted as an
                    'int', is unisolated and empowered to run any unrestricted
                    processes.  This is the default system configuration for
                    all processors.  This command requires superuser
                    authority.

     MP_PREEMPTIVE  The processor number given by arg1, interpreted as an
                    'int', has its clock scheduler enabled.  This is the
                    default for all processors.  This command requires
                    superuser authority.

     MP_NONPREEMPTIVE
                    The processor number given by arg1, interpreted as an
                    'int', has its clock scheduler disabled.  Normal process
                    time slicing is no longer enforced on that processor.  As
                    a result of turning off the clock interrupt, the interrupt
                    latency on this processor will be lower.  This command
                    requires superuser authority and is allowed only on an
                    isolated processor.  This command is not allowed on the
                    clock processor (see MP_CLOCK).

     MP_CLOCK       The processor number given by arg1, interpreted as an
                    'int', is given charge of the operating system software
                    clock (see timers(5)).  This command requires superuser
                    authority.

     MP_FASTCLOCK   The processor number given by arg1, interpreted as an
                    'int', is given charge of the operating system software
                    fast clock (see timers(5)).  This command requires
                    superuser authority.

     MP_MISER_GETREQUEST
     MP_MISER_SENDREQUEST
     MP_MISER_RESPOND
     MP_MISER_GETRESOURCE
     MP_MISER_SETRESOURCE
     MP_MISER_CHECKACCESS
                    These are all interfaces that are used to implement
                    various miser(1) functions.  These are all subject to
                    change and should not be called directly by applications.

     MP_MUSTRUN     Assigns the calling process to run only on the processor
                    number by arg1, interpreted as an 'int', except as
                    required for communications with hardware devices.  A
                    process that has allocated a CC sync register (see
                    ccsync(7m)) is restricted to running on a particular cpu.
                    Attempts to reassign such a process to another cpu will
                    fail until the CC sync register has been relinquished.

     MP_MUSTRUN_PID Assigns the process specified by arg2 to run only on the
                    processor number specified by arg1, both interpreted as
                    'int', except as required for communications with hardware
                    devices.  A process that has allocated a CC sync register
                    (see ccsync(7m)) is restricted to running on a particular
                    cpu.  Attempts to reassign such a process to another cpu
                    will fail until the CC sync register has been
                    relinquished.

     MP_GETMUSTRUN  Returns the processor the current process has been set to
                    run on using the MP_MUSTRUN command.  If the current
                    process has not been assigned to a specific processor, -1
                    is returned and errno is set to EINVAL.

     MP_GETMUSTRUN_PID
                    Returns the processor that the process specified by arg1
                    has been set to run on using the MP_MUSTRUN or
                    MP_MUSTRUN_PID command.  If the process has not been
                    assigned to a specific processor, -1 is returned and errno
                    is set to EINVAL.

     MP_RUNANYWHERE Frees the calling process to run on whatever processor the
                    system deems suitable.

     MP_RUNANYWHERE_PID
                    Frees the process specified by arg1 to run on whatever
                    processor the system deems suitable.

     MP_KERNADDR    Returns the address of various kernel data structures.
                    The structure returned is selected by arg1.  The list of
                    available structures is detailed in <sys/sysmp.h>.  This
                    option is used by many system programs to avoid having to
                    look in /unix for the location of the data structures.

     MP_SASZ        Returns the size of various system accounting structures.
                    As above, the structure returned is governed by arg1.

     MP_SAGET1      Returns the contents of various system accounting
                    structures.  The information is only for the processor
                    specified by arg4.  As above, the structure returned is
                    governed by arg1.  arg2 points to a buffer in the address
                    space of the calling process and arg3 specifies the
                    maximum number of bytes to transfer.

     MP_SAGET       Returns the contents of various system accounting
                    structures.  The information is summed across all
                    processors before it is returned.  As above, the structure
                    returned is governed by arg1.  arg2 points to a buffer in
                    the address space of the calling process and arg3
                    specifies the maximum number of bytes to transfer.

     Possible errors from sysmp are:

     [EPERM]     The effective user ID is not superuser.  Many of the commands
                 require superuser privilege.

     [EPERM]     The user ID of the sending process is not superuser, and its
                 real or effective user ID does not match the real, saved,  or
                 effective user ID of the receiving process.

     [ESRCH]     No process corresponding to that specified by a
                 MP_MUSTRUN_PID, MP_GETMUSTRUN_PID, or MP_RUNANYWHERE_PID
                 could be found.

     [EINVAL]    The processor named by a MP_EMPOWER, MP_RESTRICT, MP_CLOCK or
                 MP_SAGET1 command does not exist.

     [EINVAL]    The cmd argument is invalid.

     [EINVAL]    The arg1 argument to a MP_KERNADDR command is invalid.

     [EINVAL]    An attempt was made via MP_MUSTRUN or MP_MUSTRUN_PID to move
                 a process owning a CC sync register from the cpu controlling
                 the CC sync register.

     [EINVAL]    The target of the MP_GETMUSTRUN command has not been set to
                 run on a specific processor.

     [EBUSY]     An attempt was made to restrict the only unrestricted
                 processor or to restrict the master processor.

     [EFAULT]    An invalid buffer address has been supplied by the calling
                 process.

SEE ALSO


     mpadmin(1), runon(1), getpagesize(2), schedctl(2), timers(5)

DIAGNOSTICS

     Upon successful completion, the cmd dependent data is returned.
     Otherwise, a value of -1 is returned and errno is set to indicate the
     error.



--------------A043F6850FA9706A1CC3A389
Content-Type: text/plain; charset=us-ascii;
 name="mpadmin.man.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpadmin.man.txt"


mpadmin(1)                                                          mpadmin(1)



NAME


     mpadmin - control and report processor status

SYNOPSIS


     mpadmin -n

     mpadmin -u[processor]

     mpadmin -r[processor]

     mpadmin -c[processor]

     mpadmin -f[processor]

     mpadmin -I[processor]

     mpadmin -U[processor]

     mpadmin -D[processor]

     mpadmin -C[processor]

     mpadmin -s

DESCRIPTION


     mpadmin provides control/information of processor status.

     Exactly one argument is accepted by mpadmin at each invocation.  The
     following arguments are accepted:

     -n           Report which processors are physically configured.  The
                  numbers of the physically configured processors are written
                  to the standard output, one processor number per line.
                  Processors are numbered beginning from 0.

     -u[processor]
                  When no processor is specified, the numbers of the
                  processors that are available to schedule unrestricted
                  processes are written to the standard output.  Otherwise,
                  mpadmin enables the processor number processor to run any
                  unrestricted processes.

     -r[processor]
                  When no processor is specified, the numbers of the
                  processors that are restricted from running any processes
                  (except those assigned via the sysmp(MP_MUSTRUN) function,
                  the runon(1) command, or because of hardware necessity) are
                  written to the standard output.  Otherwise, mpadmin
                  restricts the processor numbered processor.

     -c[processor]
                  When no processor is specified, the number of the processor
                  that handles the operating system software clock is written
                  to the standard output.  Otherwise, operating system
                  software clock handling is moved to the processor numbered
                  processor.  See timers(5) for more details.

     -f[processor]
                  When no processor is specified, the number of the processor
                  that handles the operating system fast clock is written to
                  the standard output.  Otherwise, operating system fast clock
                  handling is moved to the processor numbered processor.  See
                  ftimer(1) and timers(5) for a description of the fast clock
                  usage.

     -I[processor]
                  When no processor is specified, the numbers of the
                  processors that are isolated are written to the standard
                  output.  Otherwise, mpadmin isolates the processor numbered
                  processor.  An isolated processor is restricted as by the -r
                  argument.  In addition, instruction cache and Translation
                  Lookaside Buffer synchronization are blocked, and
                  synchronization is delayed until a system service is
                  requested.

     -U[processor]
                  When no processor is specified, the numbers of the
                  processors that are not isolated are written to the standard
                  output.  Otherwise, mpadmin unisolates the processor
                  numbered processor.

     -D[processor]
                  When no processor is specified, the numbers of the
                  processors that are not running the clock scheduler are
                  written to the standard output.  Otherwise, mpadmin disables
                  the clock scheduler on the processor numbered processor.
                  This makes that processor nonpreemptive, so that normal IRIX
                  process time slicing is no longer enforced.  Processes that
                  run on a non-preemptive processor are not preempted because
                  of timer interrupts.  They are preempted only when
                  requesting a system service that causes them to wait, or
                  that makes a higher-priority process runnable (for example,
                  posting a semaphore).

     -C[processor]
                  When no processor is specified, the numbers of the
                  processors that are running the clock scheduler are written
                  to the standard output.  Otherwise, mpadmin enables the
                  clock scheduler on the processor numbered processor.
                  Processes on a preemptive processor can be preempted at the
                  end of their time slice.

     -s           A summary of the unrestricted, restricted, isolated,
                  preemptive and clock processor numbers is written to the
                  standard output.

SEE ALSO


     ftimer(1), runon(1), sysmp(2), timers(5).

DIAGNOSTICS


     When an argument specifies a processor, 0 is returned on success, -1 on
     failure.  Otherwise, the number of processors associated with argument is
     returned.

WARNINGS


     It is not possible to restrict or isolate all processors.  Processor 0
     must never be restricted or isolated.

BUGS


     Changing the clock processor may cause the system to lose a small amount
     of system time.

     When a processor is not provided as an argument, mpadmin's exit value
     will not exceed 255.  If more than 255 processors exist, mpadmin will
     return 0.

--------------A043F6850FA9706A1CC3A389--

